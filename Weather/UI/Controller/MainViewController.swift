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
