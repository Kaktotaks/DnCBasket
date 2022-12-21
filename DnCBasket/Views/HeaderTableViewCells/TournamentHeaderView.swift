//
//  TournamentHeaderView.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 16.12.2022.
//

import UIKit
import SnapKit
import Kingfisher

class TournamentHeaderView: UITableViewHeaderFooterView {
    static let idetifier = "TournamentHeaderView"

    private lazy var myBackgroundView: GradientView = {
        let value: GradientView = .init()
        value.verticalMode = true
        value.startColor = .systemGray3.withAlphaComponent(0.7)
        value.endColor = .clear
        value.clipsToBounds = true
        value.layer.cornerRadius = 8
        value.translatesAutoresizingMaskIntoConstraints = false
        return value
    }()

    private lazy var countryNameLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 16, weight: .semibold)
        value.text = "UA" // need to set configure with model
        value.textAlignment = .center
        return value
    }()

    private lazy var leagueImageView: UIImageView = {
        let value: UIImageView = .init()
        value.contentMode = .scaleAspectFit
        value.image = UIImage(named: "fbuLogo") // need to set configure with model
        return value
    }()

    private lazy var leagueNameLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 16, weight: .semibold)
        value.text = "FBU" // need to set configure with model
        value.textAlignment = .center
        return value
    }()

    private lazy var groupNameLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 16, weight: .medium)
        value.textAlignment = .left
        value.text = "Regular Season" // need to set configure with model
        value.numberOfLines = 2
        value.textAlignment = .center
        return value
    }()

    private lazy var gamesPlayedLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 16, weight: .medium)
        value.textAlignment = .center
        value.text = "GP"
        return value
    }()

    private lazy var victoriesLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 16, weight: .medium)
        value.textAlignment = .center
        value.text = "W"
        return value
    }()

    private lazy var lossesLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 16, weight: .medium)
        value.textAlignment = .center
        value.text = "L"
        return value
    }()

    // SelfPoints and AgainstPoints
    private lazy var totalPointsLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 16, weight: .medium)
        value.textAlignment = .center
        value.text = "TP"
        return value
    }()

//    func cofigure(with model: TournamentResponse) {
//        countryNameLabel.text = model.country?.name
//        let leagueImageURL = URL(string: model.league?.logo ?? Constants.noImageURL)
//        leagueImageView.kf.setImage(with: leagueImageURL)
//        groupNameLabel.text = model.group?.name
//    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        self.backgroundColor = .clear
        self.addSubview(myBackgroundView)
        self.addSubview(countryNameLabel)
        self.addSubview(leagueImageView)
        self.addSubview(leagueNameLabel)
        self.addSubview(groupNameLabel)
        self.addSubview(gamesPlayedLabel)
        self.addSubview(victoriesLabel)
        self.addSubview(lossesLabel)
        self.addSubview(totalPointsLabel)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super .layoutSubviews()

        setUpConstraint()
    }
}

extension TournamentHeaderView {
    func setUpConstraint() {
        myBackgroundView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(4)
            $0.bottom.top.equalToSuperview()
        }

        leagueImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(4)
            $0.height.equalToSuperview().dividedBy(2.2)
            $0.width.equalTo(leagueImageView.snp.height)
            $0.centerX.equalToSuperview()
        }

        countryNameLabel.snp.makeConstraints {
            $0.right.equalTo(leagueImageView.snp.left).offset(-10)
            $0.top.equalToSuperview().inset(4)
            $0.height.equalToSuperview().dividedBy(2.2)
            $0.width.equalTo(countryNameLabel.snp.height)
        }

        leagueNameLabel.snp.makeConstraints {
            $0.left.equalTo(leagueImageView.snp.right).offset(10)
            $0.top.equalToSuperview().inset(4)
            $0.height.equalToSuperview().dividedBy(2.2)
            $0.width.equalTo(leagueNameLabel.snp.height)
        }

        groupNameLabel.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(4)
            $0.height.equalToSuperview().dividedBy(2.2)
            $0.left.equalToSuperview().offset(+4)
            $0.trailing.equalTo(gamesPlayedLabel.snp.leading).offset(-8)
        }

        gamesPlayedLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(4)
            $0.height.equalToSuperview().dividedBy(2.2)
            $0.width.equalTo(40)
            $0.centerX.equalToSuperview()
        }

        victoriesLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(4)
            $0.height.equalToSuperview().dividedBy(2.2)
            $0.width.equalTo(30)
            $0.left.equalTo(gamesPlayedLabel.snp.right).offset(6)
        }

        lossesLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(4)
            $0.height.equalToSuperview().dividedBy(2.2)
            $0.width.equalTo(30)
            $0.left.equalTo(victoriesLabel.snp.right).offset(6)
        }

        totalPointsLabel.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-4)
            $0.bottom.equalToSuperview().inset(4)
            $0.height.equalToSuperview().dividedBy(2.2)
            $0.width.equalTo(80)
        }
    }
}
