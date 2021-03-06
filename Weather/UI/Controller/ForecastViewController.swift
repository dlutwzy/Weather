//
//  ForecastViewController.swift
//  Weather
//
//  Created by iMac on 2018/5/10.
//  Copyright © 2018年 iMac. All rights reserved.
//

import UIKit
import CoreLocation
import SnapKit
import RxSwift
import RxCocoa

class ForecastViewController: UIViewController {

    override func loadView() {
        super.loadView()

        updateView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white

        updateLayout()
        updateEvent()
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
    }

    private lazy var gradientLayer: CAGradientLayer = {

        let gradientLayer: CAGradientLayer = CAGradientLayer(layer: self.view.layer)

        return gradientLayer
    }()

    private let conditionIconLabel: UILabel = UILabel(textAlignment: .center,
                                                      textColor: UIColor.white,
                                                      textFont: R.font.climacons(size: Default.conditionIconFontSize))

    private let conditionDetailLabel: UILabel = UILabel(textAlignment: .center,
                                                        textColor: UIColor.white,
                                                        textFont: UIFont.systemFont(ofSize: Default.conditionDetailFontSize))

    private let locationLabel: UILabel = UILabel(textAlignment: .center,
                                                 textColor: UIColor.white,
                                                 textFont: UIFont.systemFont(ofSize: Default.locationFontSize))

    private lazy var conditionContainerView: UIView = {

        let view = UIView(frame: .zero)

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = Default.effectViewAlpha

        view.addSubview(effectView)

        return view
    }()

    private let temperatureView: TemperatureView = TemperatureView(frame: .zero)

    private lazy var forecastCollectionView: UICollectionView = {

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(FutureCollectionViewCell.self,
                                forCellWithReuseIdentifier: Default.futureCellIdentiifier)
        collectionView.delegate = self
        collectionView.dataSource = self

        return collectionView
    }()

    private var dataSource: [FutureCollectionViewCellModel]? {
        didSet {
            guard let _ = dataSource else {
                return
            }
            self.forecastCollectionView.reloadData()
        }
    }

    private var userLocation: CLLocation? {
        didSet {
            guard let location = userLocation else {
                return
            }
            DispatchQueue.global(qos: .default).async { [weak self] in
                self?.getWeatherData(location: location)
            }
        }
    }

    private let disposeBag: DisposeBag = DisposeBag()

    private struct Default {
        static let effectViewAlpha: CGFloat = 0.6
        static let conditionIconHeight: CGFloat = 180.0
        static let conditionIconFontSize: CGFloat = conditionIconHeight * 1.5
        static let conditionDetailFontSize: CGFloat = 45.0
        static let conditionDetailHeight: CGFloat = 50.0
        static let locationFontSize: CGFloat = 17.0
        static let locationHeight: CGFloat = 23.0
        static let futureCellIdentiifier = "\(FutureCollectionViewCell.self)"
        static let conditionContainerHeight: CGFloat = 80.0
    }
}

extension ForecastViewController {

    private func getWeatherData(location: CLLocation) {

        ForecastRequest.getCurrentCondition(location: location) { (result) in

            guard let result = result else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.updateConditionData(condition: result)
            }
        }

        ForecastRequest.getForecast(location: location) { (result) in
            
            guard let result = result else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.updateForecastData(forecast: result)
            }
        }
    }

    private func updateConditionData(condition: Condition) {

        conditionIconLabel.text = condition.current?.condCode?.climacon.stringValue
        conditionDetailLabel.text = condition.current?.condTxt

        var locationList = [String]()
        if let loc = condition.basic?.location {
            locationList.append(loc)
        }
        if let parentLoc = condition.basic?.parentCity {
            locationList.append(parentLoc)
        }
        if let adminArea = condition.basic?.adminArea {
            locationList.append(adminArea)
        }
        if let cnty = condition.basic?.cnty {
            locationList.append(cnty)
        }
        var locationStr = ""
        for (index, str) in locationList.enumerated() {
            locationStr += str
            if index < locationList.count - 1 {
                locationStr += ", "
            }
        }
        locationLabel.text = locationStr.capitalized

        temperatureView.currentTemperature = condition.current?.tmp
        updateGradientLayerColor(fahrenheit: CGFloat(condition.current?.tmp ?? 0))
    }

    private func updateForecastData(forecast: Forecast) {

        guard let forecastList = forecast.dailyForecast else {
            return
        }

        if dataSource == nil {
            dataSource = [FutureCollectionViewCellModel]()
        }
        dataSource?.removeAll()

        for forecast in forecastList {

            if let date = forecast.date,
                let condition = forecast.condCodeD {

                let dateFormat = DateFormatter()
                dateFormat.dateFormat = "yyyy-MM-dd"

                let dateStr = dateFormat.string(from: Date())

                let todayDate = dateFormat.date(from: dateStr)
                if todayDate == date {
                    temperatureView.lowestTemperature = forecast.tmpMin
                    temperatureView.highestTemperature = forecast.tmpMax
                }

                let calendar = Calendar(identifier: .gregorian)
                let calendarUnit = Calendar.Component.weekday
                let dateComponents = calendar.component(calendarUnit, from: date)

                let model = FutureCollectionViewCellModel(dayOfWeek: DayOfWeek(rawValue: dateComponents)!, condition: condition.climacon)
                dataSource?.append(model)
            }
        }
        forecastCollectionView.reloadData()

        conditionDetailLabel.text = (forecast.dailyForecast![0] as DailyForecast).condTxtD
    }
}

extension ForecastViewController {

    private func updateView() {

        self.view.layer.addSublayer(gradientLayer)

        self.view.addSubview(conditionIconLabel)
        self.view.addSubview(conditionDetailLabel)
        self.view.addSubview(locationLabel)

        self.view.addSubview(conditionContainerView)

        conditionContainerView.addSubview(temperatureView)
        conditionContainerView.addSubview(forecastCollectionView)
    }

    private func updateGradientLayerLayout() {
        gradientLayer.frame = self.view.layer.bounds
    }

    private func updateLayout() {

        updateGradientLayerLayout()

        conditionIconLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.centerY.equalToSuperview().multipliedBy(0.5)
            maker.right.equalToSuperview()
            maker.height.equalTo(Default.conditionIconHeight)
        }

        conditionDetailLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.top.equalTo(conditionIconLabel.snp.bottom).offset(Config.commonTopOffset)
            maker.right.equalToSuperview()
            maker.height.equalTo(Default.conditionDetailHeight)
        }

        locationLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.top.equalTo(conditionDetailLabel.snp.bottom).offset(Config.commonTopOffset)
            maker.right.equalToSuperview()
            maker.height.equalTo(Default.locationHeight)
        }

        conditionContainerView.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.top.equalTo(locationLabel.snp.bottom).offset(Config.commonTopOffset)
            maker.right.equalToSuperview()
            maker.height.equalTo(Default.conditionContainerHeight)
        }

        temperatureView.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview().offset(Config.commonLeftOffset)
            maker.top.equalToSuperview()
            maker.width.equalTo(temperatureView.snp.height).multipliedBy(1.2)
            maker.bottom.equalToSuperview().offset(-5.0)
        }

        forecastCollectionView.snp.makeConstraints { (maker) in
            maker.left.equalTo(temperatureView.snp.right).offset(Config.commonLeftOffset)
            maker.top.equalToSuperview().offset(5.0)
            maker.right.equalToSuperview().offset(Config.commonRightOffset)
            maker.bottom.equalToSuperview().offset(-5.0)
        }
    }

    private func updateGradientLayerColor(fahrenheit: CGFloat) {

        gradientLayer.colors = ConditionColorType(fahrenheit: fahrenheit)?.colorPackage().map({
            $0.cgColor
        })
        gradientLayer.locations = [0.5, 1.0]
    }

    private func updateEvent() {


        self.view.rx.observeWeakly(CGRect.self, "bounds")
            .takeUntil(self.view.rx.deallocated)
            .subscribe(onNext: { [weak self] (_) in
                self?.updateGradientLayerLayout()
                }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: self.disposeBag)

        forecastCollectionView.rx.observeWeakly(CGRect.self, "bounds")
            .takeUntil(forecastCollectionView.rx.deallocated)
            .subscribe(onNext: { [weak self] (_) in
                self?.resetCollectionLayout(collection: self?.forecastCollectionView)
                }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: self.disposeBag)
    }

    private func resetCollectionLayout(collection: UICollectionView?) {

        guard let collection = collection else {
            return
        }

        let layout = UICollectionViewFlowLayout()

        let frame = collection.bounds
        let width = frame.width / 3.0
        let height = frame.height
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        layout.scrollDirection = .horizontal

        collection.collectionViewLayout = layout
    }
}

extension ForecastViewController: UICollectionViewDelegate {

}

extension ForecastViewController: UICollectionViewDataSource {
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
