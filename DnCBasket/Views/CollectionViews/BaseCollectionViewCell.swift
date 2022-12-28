//
//  LeagueCollectionViewCell.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 14.12.2022.
//

import UIKit
import Kingfisher
import SnapKit

class BaseCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants and Variables
    static let identifier = "BaseCollectionViewCell"

    lazy var myBackgroundView: GradientView = {
        let value: GradientView = .init()
        value.diagonalMode = true
        value.startColor = Constants.redColor.withAlphaComponent(0.7)
        value.endColor = .clear
        value.clipsToBounds = true
        value.layer.cornerRadius = self.contentView.frame.height / 5
        value.translatesAutoresizingMaskIntoConstraints = false
        return value
    }()

    private lazy var objectImageView: UIImageView = {
        let value: UIImageView = .init()
        value.contentMode = .scaleAspectFit
        value.image = UIImage(named: "fbuLogo")
        value.clipsToBounds = true
        value.layer.cornerRadius = 15
        return value
    }()

    private lazy var objectNameLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 14, weight: .semibold)
        value.contentMode = .center
        value.textAlignment = .center
        value.numberOfLines = 2
        value.text = "TestFBU"
        return value
    }()

    private lazy var objectCountryNameLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 10, weight: .regular)
        value.contentMode = .center
        value.textAlignment = .center
        value.numberOfLines = 2
        value.text = "TestUkraine"
        return value
    }()

    // MARK: - Functions
    func configureLeague(with model: LeagueResponse) {
        let leagueImageURL = URL(string: model.logo ?? Constants.noImageURL)
        objectImageView.kf.setImage(with: leagueImageURL)
        objectNameLabel.text = model.name
        objectCountryNameLabel.text = model.country?.name
    }

    func configureTeam(with model: TeamResponse) {
        let teamImageURL = URL(string: model.logo ?? Constants.noImageURL)
        objectImageView.kf.setImage(with: teamImageURL)
        objectNameLabel.text = model.name
        objectCountryNameLabel.text = model.country?.name
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setUpUI()
    }

    private func setUpUI() {
        contentView.addSubview(myBackgroundView)
        myBackgroundView.addSubview(objectImageView)
        myBackgroundView.addSubview(objectNameLabel)
        myBackgroundView.addSubview(objectCountryNameLabel)

        myBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(2)
        }

        objectImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(12)
            $0.height.equalToSuperview().dividedBy(2)
        }

        objectNameLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(objectImageView.snp.bottom)
            $0.height.equalTo(30)
        }

        objectCountryNameLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview().inset(4)
            $0.height.equalTo(30)
        }
    }
}
