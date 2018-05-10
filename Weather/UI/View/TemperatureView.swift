//
//  TemperatureView.swift
//  Weather
//
//  Created by iMac on 2018/5/10.
//  Copyright © 2018年 iMac. All rights reserved.
//

import UIKit

class TemperatureView: UIView {

    override init(frame: CGRect) {

        super.init(frame: frame)

        updateUI()
        updateLayout()
    }

    private let currentLabel: UILabel = UILabel(textAlignment: .center,
                                                textColor: UIColor.white,
                                                textFont: UIFont.systemFont(ofSize: Default.currentFontSize))
    private let lowestLabel: UILabel = UILabel(textAlignment: .center,
                                               textColor: UIColor.white,
                                               textFont: UIFont.systemFont(ofSize: Default.commonFontSize))
    private let highestLabel: UILabel = UILabel(textAlignment: .center,
                                                textColor: UIColor.white,
                                                textFont: UIFont.systemFont(ofSize: Default.commonFontSize))

    private struct Default {
        static let currentFontSize: CGFloat = 52.0
        static let commonFontSize: CGFloat = 17.0
    }

    private func updateUI() {

        self.addSubview(currentLabel)
        self.addSubview(lowestLabel)
        self.addSubview(highestLabel)
    }

    private func updateLayout() {

        currentLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.top.equalToSuperview()
            maker.right.equalToSuperview()
            maker.height.equalToSuperview().multipliedBy(0.75)
        }

        lowestLabel.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.top.equalTo(currentLabel.snp.bottom)
            maker.width.equalToSuperview().multipliedBy(0.5)
            maker.bottom.equalToSuperview()
        }

        highestLabel.snp.makeConstraints { (maker) in
            maker.width.equalToSuperview().multipliedBy(0.5)
            maker.top.equalTo(currentLabel.snp.bottom)
            maker.right.equalToSuperview()
            maker.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
