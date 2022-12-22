//
//  TeamPlaceTableViewCell.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 15.12.2022.
//

import UIKit
import SnapKit
import Kingfisher

class TeamPlaceTableViewCell: UITableViewCell {
    static let identifier = "TeamPlaceTableViewCell"

    private lazy var myBackgroundView: GradientView = {
        let value: GradientView = .init()
        value.diagonalMode = true
        value.startColor = Constants.redColor.withAlphaComponent(0.7)
        value.endColor = .clear
        value.clipsToBounds = true
        value.layer.cornerRadius = 4
        value.translatesAutoresizingMaskIntoConstraints = false
        return value
    }()

    // set private after model seted
    lazy var positionLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 16, weight: .medium)
        value.text = "10"
        return value
    }()

    private lazy var teamImageView: UIImageView = {
        let value: UIImageView = .init()
        value.contentMode = .scaleAspectFit
        value.image = UIImage(named: "fbuLogo")
        return value
    }()

    private lazy var teamNameLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 14, weight: .regular)
        value.textAlignment = .center
        value.text = "BC DniproBasket"
        value.numberOfLines = 2
        return value
    }()

    private lazy var gamesPlayedLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 14, weight: .regular)
        value.textAlignment = .center
        value.text = "10"
        return value
    }()

    private lazy var victoriesLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 14, weight: .regular)
        value.textAlignment = .center
        value.text = "5"
        return value
    }()

    private lazy var lossesLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 14, weight: .regular)
        value.textAlignment = .center
        value.text = "5"
        return value
    }()

    // SelfPoints and AgainstPoints
    private lazy var totalPointsLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 14, weight: .regular)
        value.textAlignment = .center
        value.text = "3455:2456"
        return value
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        setUpUI()
    }

    func configure(with placeModel: TournamentResponse) {
        let teamImageURL = URL(string: placeModel.team?.logo ?? Constants.noImageURL)
        teamImageView.kf.setImage(with: teamImageURL)
        positionLabel.text = placeModel.position?.description
        teamNameLabel.text = placeModel.team?.name
        gamesPlayedLabel.text = placeModel.games?.played?.description
        victoriesLabel.text = placeModel.games?.win?.total?.description
        lossesLabel.text = placeModel.games?.lose?.total?.description
        guard
            let homePoints = placeModel.points?.selfPoints,
            let guestPoints = placeModel.points?.againstPoints
        else {
            return
        }
        totalPointsLabel.text = "\(homePoints):\(guestPoints)"
    }
}

extension TeamPlaceTableViewCell {
    private func setUpUI() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 4, bottom: 0, right: 4))
        contentView.addSubview(myBackgroundView)
        myBackgroundView.addSubview(positionLabel)
        myBackgroundView.addSubview(teamImageView)
        myBackgroundView.addSubview(teamNameLabel)
        myBackgroundView.addSubview(gamesPlayedLabel)
        myBackgroundView.addSubview(victoriesLabel)
        myBackgroundView.addSubview(lossesLabel)
        myBackgroundView.addSubview(totalPointsLabel)

        myBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        positionLabel.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.leading.equalToSuperview().inset(6)
            $0.width.equalTo(20)
        }

        teamImageView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.left.equalTo(positionLabel.snp.right).offset(6)
            $0.width.equalTo(30)
        }

        teamNameLabel.snp.makeConstraints {
            $0.left.equalTo(teamImageView.snp.right).offset(6)
            $0.height.equalToSuperview()
            $0.width.equalToSuperview().dividedBy(4)
        }

        gamesPlayedLabel.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(40)
        }

        victoriesLabel.snp.makeConstraints {
            $0.left.equalTo(gamesPlayedLabel.snp.right).offset(6)
            $0.height.equalToSuperview()
            $0.width.equalTo(30)
        }

        lossesLabel.snp.makeConstraints {
            $0.left.equalTo(victoriesLabel.snp.right).offset(6)
            $0.height.equalToSuperview()
            $0.width.equalTo(30)
        }

        totalPointsLabel.snp.makeConstraints {
            $0.trailing.height.equalToSuperview()
            $0.width.equalTo(80)
        }
    }
}
