//
//  GamesTableViewCell.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 12.12.2022.
//

import UIKit
import SnapKit

class GameTableViewCell: UITableViewCell {
    static let identifier = "GamesTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()

//        setUpUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setUpUI()
    }

    private lazy var myBackgroundView: GradientView = {
        let value = GradientView()
        value.verticalMode = true
        value.startColor = Constants.redColor.withAlphaComponent(0.7)
        value.endColor = .clear
        value.clipsToBounds = true
        value.layer.cornerRadius = 20
//        value.translatesAutoresizingMaskIntoConstraints = false
        return value
    }()

    private lazy var addToFavouritesButton: UIButton = {
        let value = UIButton()
        value.setImage(UIImage(systemName: "pin"), for: .normal)
        value.backgroundColor = .systemGray3.withAlphaComponent(0.7)
//        value.addTarget(self, action: #selector(addToFavouritesButtonPressed), for: .touchUpInside)
        value.layer.cornerRadius = 10
        return value
    }()

    private lazy var countryImageView: UIImageView = {
        let value = UIImageView()
        value.contentMode = .scaleAspectFill
        value.backgroundColor = .green
        return value
    }()

    private lazy var leagueImageView: UIImageView = {
        let value = UIImageView()
        value.contentMode = .scaleAspectFill
        value.backgroundColor = .gray
        return value
    }()

    private lazy var homeTeamImageView: UIImageView = {
        let value = UIImageView()
        value.contentMode = .scaleAspectFill
        value.backgroundColor = .white
        return value
    }()

    private lazy var guestTeamImageView: UIImageView = {
        let value = UIImageView()
        value.contentMode = .scaleAspectFill
        value.backgroundColor = .gray
        return value
    }()

    private lazy var homeTeamNameLable: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 18, weight: .heavy)
        value.contentMode = .center
        value.textAlignment = .center
        value.text = "No name"
        return value
    }()

    private lazy var guestTeamNameLable: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 18, weight: .heavy)
        value.contentMode = .center
        value.textAlignment = .center
        value.text = "No name"
        return value
    }()

    private lazy var homeTotalScoreLabel: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 18, weight: .heavy)
        value.contentMode = .center
        value.textAlignment = .center
        value.text = "-"
        return value
    }()

    private lazy var guestTotalScoreLabel: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 18, weight: .heavy)
        value.contentMode = .center
        value.textAlignment = .center
        value.text = "-"
        return value
    }()

    private lazy var dateLabel: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 12, weight: .medium)
        value.contentMode = .center
        value.textAlignment = .center
        value.text = "00.00.00"
        return value
    }()

    private lazy var timeLabel: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 12, weight: .medium)
        value.contentMode = .center
        value.textAlignment = .center
        value.text = "00:00"
        return value
    }()
}

extension GameTableViewCell {
    private func setUpUI() {
        contentView.addSubview(myBackgroundView)
//        myBackgroundView.addSubview(addToFavouritesButton)
        myBackgroundView.addSubview(homeTeamImageView)
        myBackgroundView.addSubview(guestTeamImageView)
        myBackgroundView.addSubview(dateLabel)
        myBackgroundView.addSubview(timeLabel)
        myBackgroundView.addSubview(countryImageView)
        myBackgroundView.addSubview(leagueImageView)
        myBackgroundView.addSubview(homeTeamNameLable)
        myBackgroundView.addSubview(guestTeamNameLable)
        myBackgroundView.addSubview(homeTotalScoreLabel)
        myBackgroundView.addSubview(guestTotalScoreLabel)
//
//
        myBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(6)
        }
//
        countryImageView.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(45)
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }

        leagueImageView.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(45)
            $0.top.equalTo(countryImageView.snp.bottom)
            $0.centerX.equalToSuperview()
        }

        homeTeamImageView.snp.makeConstraints {
            $0.height.width.equalToSuperview().dividedBy(2)
            $0.top.leading.equalToSuperview()
        }

        guestTeamImageView.snp.makeConstraints {
            $0.height.width.equalToSuperview().dividedBy(2)
            $0.top.trailing.equalToSuperview()
        }
//
        homeTeamNameLable.snp.makeConstraints {
            $0.top.equalTo(homeTeamImageView.snp.bottom)
            $0.width.equalTo(homeTeamImageView)
            $0.height.equalTo(18)
            $0.centerX.equalTo(homeTeamImageView)
        }

        guestTeamNameLable.snp.makeConstraints {
            $0.top.equalTo(guestTeamImageView.snp.bottom)
            $0.width.equalTo(guestTeamNameLable)
            $0.height.equalTo(18)
            $0.centerX.equalTo(guestTeamImageView)
        }

        homeTotalScoreLabel.snp.makeConstraints {
            $0.top.equalTo(homeTeamNameLable.snp.bottom)
            $0.centerX.equalTo(homeTeamNameLable)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(homeTeamNameLable)

        }

        guestTotalScoreLabel.snp.makeConstraints {
            $0.top.equalTo(guestTeamNameLable.snp.bottom)
            $0.centerX.equalTo(guestTeamNameLable)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(guestTeamNameLable)
        }

        dateLabel.snp.makeConstraints {
            $0.bottom.equalTo(timeLabel.snp.top)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(20)
        }

        timeLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(20)
        }
    }
}
