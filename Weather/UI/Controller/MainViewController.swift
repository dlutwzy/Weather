//
//  MainViewController.swift
//  Weather
//
//  Created by iMac on 2018/5/7.
//  Copyright © 2018年 iMac. All rights reserved.
//

import UIKit
import CoreLocation
import ForecastIO
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

        conditionIconLabel.text = String(climacons: .cloud)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private let conditionContainerView: UIView = UIView()

    private lazy var conditionIconLabel: UILabel = {

        let label = UILabel(frame: .zero)

        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = R.font.climacons(size: Default.conditionIconFontSize)

        return label
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

    private lazy var futureConditionCollection: UICollectionView = {

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        return collectionView
    }()

    private lazy var locationManager: CLLocationManager = {
        
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        manager.distanceFilter = kCLLocationAccuracyThreeKilometers
        manager.delegate = self

        return manager
    }()

    private lazy var dsClient: DarkSkyClient = {
        
        let client = DarkSkyClient(apiKey: Config.secretKey)
        client.units = .si
        client.language = .simplifiedChinese

        return client
    }()

    private let updateSemaphore: DispatchSemaphore = DispatchSemaphore(value: 1)

    private struct Default {
        static let conditionIconFontSize: CGFloat = 180.0
        static let conditionDetailFontSize: CGFloat = 45.0
        static let locationFontSize: CGFloat = 17.0
        static let currentTemperatureFontSize: CGFloat = 52.0
        static let commonTemperatureFontSize: CGFloat = 17.0
    }
}

extension MainViewController {

    private func updateView() {

        self.view.addSubview(conditionIconLabel)
    }

    private func updateLayout() {

        conditionIconLabel.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.width.equalToSuperview()
            maker.height.equalToSuperview()
        }
    }
    
    private func updateEvent() {
        
        _ = futureConditionCollection.rx.observeWeakly(CGRect.self, "bounds")
            .takeUntil(futureConditionCollection.rx.deallocated)
            .subscribe(onNext: { [weak self] (_) in
                self?.resetCollectionLayout(collection: self?.futureConditionCollection)
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

class FutureCollectionViewCell: UICollectionViewCell {
    
    var dayOfWeek: String? {
        set { dayOfWeekLabel.text = newValue }
        get { return dayOfWeekLabel.text }
    }
    
    var condition: Climacons? {
        set {
            guard let newValue = newValue else {
                return
            }
            conditionLabel.text = String(climacons: newValue)
        }
        get {
            return Climacons(rawValue: conditionLabel.text ?? "")
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        updateView()
        updateLayout()
    }
    
    private lazy var dayOfWeekLabel: UILabel = {
        
        let label = UILabel(frame: .zero)
        
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: Default.weekdayFontSize)
        label.textColor = UIColor.white
        
        return label
    }()
    
    private lazy var conditionLabel: UILabel = {
        
        let label = UILabel(frame: .zero)
        
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: Default.conditionFontSize)
        label.textColor = UIColor.white
        
        return label
    }()
    
    private struct Default {
        static let weekdayFontSize: CGFloat = 17.0
        static let conditionFontSize: CGFloat = 40.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FutureCollectionViewCell {
    
    private func updateView() {
        
        self.addSubview(dayOfWeekLabel)
        self.addSubview(conditionLabel)
    }
    
    private func updateLayout() {
        
        let weekdayLabelHeight = Default.weekdayFontSize * 2
        let conditionLabelHeight = Default.conditionFontSize
        let totalHeight = weekdayLabelHeight + conditionLabelHeight
        let weekdayLabelCenterYOffset = weekdayLabelHeight/2 - totalHeight/2
        let conditionLabelCenterYOffset = (weekdayLabelHeight + conditionLabelHeight/2) - totalHeight/2
        
        dayOfWeekLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.height.equalTo(weekdayLabelHeight)
            maker.right.equalToSuperview()
            maker.centerY.equalToSuperview().offset(weekdayLabelCenterYOffset)
        }
        
        conditionLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.height.equalTo(conditionLabelHeight)
            maker.right.equalToSuperview()
            maker.centerY.equalToSuperview().offset(conditionLabelCenterYOffset)
        }
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

    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {

    }
}

