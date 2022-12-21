//
//  YearsCollectionViewCell.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 21.12.2022.
//

import UIKit
import Kingfisher

class YearsCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants and Variables
    static let identifier = "YearsCollectionViewCell"

    private lazy var myBackgroundView: GradientView = {
        let value: GradientView = .init()
        value.diagonalMode = true
        value.startColor = Constants.redColor.withAlphaComponent(0.7)
        value.endColor = .clear
        value.clipsToBounds = true
        value.layer.cornerRadius = self.contentView.frame.height / 5
        value.translatesAutoresizingMaskIntoConstraints = false
        return value
    }()

    private lazy var seasonYearsLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 16, weight: .semibold)
        value.contentMode = .center
        value.textAlignment = .center
        value.numberOfLines = 0
        value.text = "2022"
        return value
    }()

    // MARK: - Functions
    func configure(with model: Seasons) {
        seasonYearsLabel.text = model.season?.description
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setUpUI()
    }

    private func setUpUI() {
        contentView.addSubview(myBackgroundView)
        myBackgroundView.addSubview(seasonYearsLabel)

        myBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(2)
        }

        seasonYearsLabel.snp.makeConstraints {
            $0.width.height.equalToSuperview().inset(2)
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
