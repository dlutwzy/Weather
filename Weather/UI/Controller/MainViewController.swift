//
//  MainViewController.swift
//  Weather
//
//  Created by iMac on 2018/5/7.
//  Copyright © 2018年 iMac. All rights reserved.
//

import UIKit
import CoreLocation
import SnapKit
import RxSwift
import RxCocoa

enum InitializeViewType {
    case userSwitch
    case byLocation(location: CLLocation)
    case needSwitch
    case connectFailed
}

class MainViewController: UIViewController {

    override func loadView() {
        super.loadView()

        updateView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.gray

        updateLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        conditionIconLabel.text = String(climacons: .sun)
        UIImage.conditionImage(icon: .cloudy) { [weak self] (image) in
            self?.conditionIconImageView.image = image
        }
        conditionDetailLabel.text = "Clear"
        locationLabel.text = "Sana'a, Yemen"
        currentTemperatureLabel.text = "13°"
        lowestTemperatureLabel.text = "L 14"
        highestTemperatureLabel.text = "H 29"

        updateGradientLayerColor(fahrenheit: 15.0)

        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func updateGradientLayerColor(fahrenheit: CGFloat) {

        gradientLayer.colors = ConditionColorType(fahrenheit: fahrenheit)?.colorPackage().map({
            $0.cgColor
        })
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer: CAGradientLayer = CAGradientLayer(layer: self.view.layer)

        gradientLayer.colors = ConditionColorType(fahrenheit: 35.0)?.colorPackage().map({
            $0.cgColor
        })
        gradientLayer.locations = [0.5, 1.0]

        return gradientLayer
    }()

    private lazy var conditionContainerView: UIView = {

        let view = UIView(frame: .zero)

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = Default.effectViewAlpha

        view.addSubview(effectView)

        return view
    }()

    private lazy var conditionIconImageView: UIImageView = {

        let imageView = UIImageView(frame: .zero)

        return imageView
    }()

    private lazy var conditionDetailLabel: UILabel = {

        let label = UILabel(frame: .zero)

        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: Default.conditionDetailFontSize)

        return label
    }()

    private lazy var locationLabel: UILabel = {

        let label = UILabel(frame: .zero)

        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: Default.locationFontSize)

        return label
    }()

    private let temperatureContainerView: UIView = UIView(frame: .zero)
    private lazy var currentTemperatureLabel: UILabel = {

        let label = UILabel(frame: .zero)

        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: Default.currentTemperatureFontSize)

        return label
    }()
    private lazy var lowestTemperatureLabel: UILabel = {

        let label = UILabel(frame: .zero)

        label.textAlignment = .left
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: Default.commonTemperatureFontSize)

        return label
    }()
    private lazy var highestTemperatureLabel: UILabel = {

        let label = UILabel(frame: .zero)

        label.textAlignment = .right
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: Default.commonTemperatureFontSize)

        return label
    }()

    private lazy var futureConditionCollectionView: UICollectionView = {

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(FutureCollectionViewCell.self,
                                forCellWithReuseIdentifier: Default.futureCellIdentiifier)
        collectionView.delegate = self
        collectionView.dataSource = self

        return collectionView
    }()

    private lazy var locationManager: CLLocationManager = {
        
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        manager.distanceFilter = kCLLocationAccuracyThreeKilometers
        manager.delegate = self

        return manager
    }()

    var dataSource: [FutureCollectionViewCellModel]? {
        didSet {
            guard let _ = dataSource else {
                return
            }
            self.futureConditionCollectionView.reloadData()
        }
    }

    private let updateSemaphore: DispatchSemaphore = DispatchSemaphore(value: 1)
    private var userLocation: CLLocation? {
        didSet {
            guard let _ = userLocation else {
                return
            }
            if updateSemaphore.wait(timeout: DispatchTime.now()) == .success {
                locationManager.stopUpdatingLocation()
                DispatchQueue.global(qos: .default).async { [weak self] in
                    self?.getWeatherData()
                    //self?.updateSemaphore.signal()
                }
            }
        }
    }

    private func getWeatherData() {
        return
        guard let location = userLocation else {
            return
        }

        ForecastRouter.now(location: location).request()
            .responseString { (response) in
                guard let value = response.result.value else {
                    return
                }
                print(value)
        }

        ForecastRequest.getForecast(location: location) { (result) in
            guard let result = result else {
                return
            }
            print(result)
            DispatchQueue.main.async { [weak self] in
                self?.updateForecastData(data: result)
            }
        }
    }

    private func updateConditionData(data: Condition) {

//        conditionIconLabel.text = data.current?.condCode
        currentTemperatureLabel.text = "\(data.current?.tmp ?? "")°"
//        lowestTemperatureLabel.text = "L \(data.current.)"
    }

    private func updateForecastData(data: Forecast) {

        conditionDetailLabel.text = (data.dailyForecast![0] as DailyForecast).condTxtD
//        conditionIconLabel.text = String(climacons: Climacons(icon: data.currently?.icon ?? .cloudy))
//        currentTemperatureLabel.text = "\(data.currently?.temperature ?? 0)°"
    }

    private struct Default {
        static let effectViewAlpha: CGFloat = 0.6
        static let conditionIconHeight: CGFloat = 150.0
        static let conditionIconFontSize: CGFloat = conditionIconHeight * 1.5
        static let conditionDetailFontSize: CGFloat = 45.0
        static let locationFontSize: CGFloat = 17.0
        static let currentTemperatureFontSize: CGFloat = 52.0
        static let commonTemperatureFontSize: CGFloat = 17.0
        static let futureCellIdentiifier = "\(FutureCollectionViewCell.self)"
        static let conditionContainerHeight: CGFloat = 80.0
    }
}

extension MainViewController {

    private func updateView() {

        self.view.layer.addSublayer(gradientLayer)
        self.view.addSubview(conditionIconImageView)
        self.view.addSubview(conditionDetailLabel)
        self.view.addSubview(locationLabel)

        self.view.addSubview(conditionContainerView)

        conditionContainerView.addSubview(temperatureContainerView)
        conditionContainerView.addSubview(futureConditionCollectionView)

        temperatureContainerView.addSubview(currentTemperatureLabel)
        temperatureContainerView.addSubview(lowestTemperatureLabel)
        temperatureContainerView.addSubview(highestTemperatureLabel)
    }

    private func updateGradientLayerLayout() {
        gradientLayer.frame = self.view.layer.bounds
    }

    private func updateLayout() {

        updateGradientLayerLayout()

        conditionIconImageView.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview().multipliedBy(0.5)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(Default.conditionIconHeight)
            maker.height.equalTo(Default.conditionIconHeight)
        }

        conditionDetailLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.top.equalTo(conditionIconImageView.snp.bottom).offset(Config.commonTopOffset)
            maker.right.equalToSuperview()
            maker.height.equalTo(Default.conditionDetailFontSize)
        }

        locationLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.top.equalTo(conditionDetailLabel.snp.bottom).offset(Config.commonTopOffset)
            maker.right.equalToSuperview()
            maker.height.equalTo(Default.locationFontSize)
        }

        conditionContainerView.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.top.equalTo(locationLabel.snp.bottom).offset(Config.commonTopOffset)
            maker.right.equalToSuperview()
            maker.height.equalTo(Default.conditionContainerHeight)
        }

        temperatureContainerView.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(Config.commonLeftOffset)
            maker.top.equalToSuperview()
            maker.width.equalTo(temperatureContainerView.snp.height)
            maker.bottom.equalToSuperview()
        }

        futureConditionCollectionView.snp.makeConstraints { (maker) in
            maker.left.equalTo(temperatureContainerView.snp.right).offset(Config.commonLeftOffset)
            maker.top.equalToSuperview()
            maker.right.equalToSuperview().offset(Config.commonRightOffset)
            maker.bottom.equalToSuperview()
        }

        currentTemperatureLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.top.equalToSuperview()
            maker.right.equalToSuperview()
            maker.height.equalToSuperview().multipliedBy(0.75)
        }

        lowestTemperatureLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.top.equalTo(currentTemperatureLabel.snp.bottom)
            maker.width.equalToSuperview().multipliedBy(0.5)
            maker.bottom.equalToSuperview()
        }

        highestTemperatureLabel.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview().multipliedBy(0.5)
            maker.top.equalTo(currentTemperatureLabel.snp.bottom)
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
    
    private func updateEvent() {

        _ = self.view.rx.observeWeakly(CGRect.self, "bounds")
            .takeUntil(self.view.rx.deallocated)
            .subscribe(onNext: { [weak self] (_) in
                self?.updateGradientLayerLayout()
            }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        _ = futureConditionCollectionView.rx.observeWeakly(CGRect.self, "bounds")
            .takeUntil(futureConditionCollectionView.rx.deallocated)
            .subscribe(onNext: { [weak self] (_) in
                self?.resetCollectionLayout(collection: self?.futureConditionCollectionView)
            }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
    
    private func resetCollectionLayout(collection: UICollectionView?) {
        
        guard let collection = collection else {
            return
        }
        
        let layout = UICollectionViewFlowLayout()
        
        let frame = collection.bounds
        let width = frame.width / 3.3
        let height = frame.height
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 2.0
        layout.minimumLineSpacing = 0.0
        layout.scrollDirection = .horizontal
        
        collection.collectionViewLayout = layout
    }
}

extension MainViewController: UICollectionViewDelegate {

}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataSource = dataSource else {
            return 0
        }
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Default.futureCellIdentiifier,
                                                      for: indexPath)

        let futureConditionCell = cell as? FutureCollectionViewCell
        futureConditionCell?.item = dataSource?[indexPath.row]

        return cell
    }

}

extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {

        case .notDetermined:
            break
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways:
            fallthrough
        case .authorizedWhenInUse:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLocation = locations.last
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

    }
}

