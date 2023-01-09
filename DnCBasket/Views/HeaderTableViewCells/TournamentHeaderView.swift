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
    // MARK: - Constants and Variables
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

    private var countryNameLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 16, weight: .semibold)
        value.textAlignment = .center
        return value
    }()

    private var leagueImageView: UIImageView = {
        let value: UIImageView = .init()
        value.contentMode = .scaleAspectFit
        return value
    }()

    private var leagueNameLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 16, weight: .semibold)
        value.textAlignment = .center
        return value
    }()

    private lazy var teamsLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 16, weight: .medium)
        value.textAlignment = .left
        value.text = Constants.teamsTabBarTitle
        value.numberOfLines = 2
        value.textAlignment = .center
        return value
    }()

    private lazy var gamesPlayedLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 16, weight: .medium)
        value.textAlignment = .center
        value.text = Constants.gamesPlayedTitle
        return value
    }()

    private lazy var victoriesLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 16, weight: .medium)
        value.textAlignment = .center
        value.text = Constants.wictoriesTitle
        return value
    }()

    private lazy var lossesLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 16, weight: .medium)
        value.textAlignment = .center
        value.text = Constants.lossesTitle
        return value
    }()

    // SelfPoints and AgainstPoints
    private lazy var totalPointsLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 16, weight: .medium)
        value.textAlignment = .center
        value.text = Constants.totalPointsTitle
        return value
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        self.backgroundColor = .clear
        self.addSubview(myBackgroundView)
        self.addSubview(countryNameLabel)
        self.addSubview(leagueImageView)
        self.addSubview(leagueNameLabel)
        self.addSubview(teamsLabel)
        self.addSubview(gamesPlayedLabel)
        self.addSubview(victoriesLabel)
        self.addSubview(lossesLabel)
        self.addSubview(totalPointsLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("Fatal error while Tournament constraints init")
    }

    // MARK: - Methods
    override func layoutSubviews() {
        super .layoutSubviews()

        setUpConstraint()
    }

    func configure(model: TournamentResponse?) {
        let leagueImageURL = URL(string: model?.league?.logo ?? Constants.noImageURL)
        leagueImageView.kf.setImage(with: leagueImageURL)
        countryNameLabel.text = model?.country?.name
        leagueNameLabel.text = model?.league?.name
    }
}

// MARK: - UI setup.
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
            $0.left.equalToSuperview().offset(+4)
        }

        leagueNameLabel.snp.makeConstraints {
            $0.left.equalTo(leagueImageView.snp.right).offset(10)
            $0.top.equalToSuperview().inset(4)
            $0.height.equalToSuperview().dividedBy(2.2)
            $0.right.equalToSuperview().offset(-4)
        }

        teamsLabel.snp.makeConstraints {
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
