//
//  FutureCollectionViewCell.swift
//  Weather
//
//  Created by iMac on 2018/5/8.
//  Copyright © 2018年 iMac. All rights reserved.
//

import UIKit

class FutureCollectionViewCell: UICollectionViewCell {

    var item: FutureCollectionViewCellModel? {
        didSet {
            guard let item = item else {
                return
            }
            dayOfWeekLabel.text = item.dayOfWeek
            conditionLabel.text = String(climacons: item.condition)
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
