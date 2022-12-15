//
//  LeagueCollectionViewCell.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 14.12.2022.
//

import UIKit
import Kingfisher

class LeagueCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants and Variables
    static let identifier = "LeagueCollectionViewCell"

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

    private lazy var leagueImageView: UIImageView = {
        let value: UIImageView = .init()
        value.contentMode = .scaleAspectFit
        value.backgroundColor = .systemGray3.withAlphaComponent(0.3)
        value.clipsToBounds = true
        value.backgroundColor = .yellow
        value.layer.cornerRadius = 20
        return value
    }()

    private lazy var leagueNameLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 12, weight: .regular)
        value.contentMode = .center
        value.textAlignment = .center
        value.numberOfLines = 2
        value.clipsToBounds = true
        value.backgroundColor = .green
        value.layer.cornerRadius = 20
        return value
    }()

    private lazy var countryNameLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 8, weight: .thin)
        value.contentMode = .center
        value.textAlignment = .center
        value.numberOfLines = 2
        value.clipsToBounds = true
        value.backgroundColor = .gray
        value.layer.cornerRadius = 20
        return value
    }()

    // MARK: - Functions
    func configure(with model: LeagueResponse) {
        let leagueImageURL = URL(string: model.logo ?? Constants.noImageURL)
        leagueImageView.kf.setImage(with: leagueImageURL)
        leagueNameLabel.text = model.name
        countryNameLabel.text = model.country?.name
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setUpUI()
    }

    private func setUpUI() {
        contentView.addSubview(myBackgroundView)
        myBackgroundView.addSubview(leagueImageView)
        myBackgroundView.addSubview(leagueNameLabel)
        myBackgroundView.addSubview(countryNameLabel)

        myBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(2)
        }

        leagueImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(2)
        }

        leagueNameLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(leagueImageView.snp.bottom).inset(4)
            $0.height.equalTo(30)
        }

        countryNameLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview().inset(4)
            $0.height.equalTo(30)
        }
    }
}
