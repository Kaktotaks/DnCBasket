//
//  GamesTableViewCell.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 12.12.2022.
//

import UIKit
import SnapKit
import Kingfisher

class GameTableViewCell: UITableViewCell {
    static let identifier = "GamesTableViewCell"
    public var buttonTogled = false

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
        value.translatesAutoresizingMaskIntoConstraints = false
        return value
    }()

    private lazy var addToFavouritesButton: UIButton = {
        let value = UIButton()
        value.setImage(UIImage(systemName: "pin"), for: .normal)
        value.tintColor = .label
        value.contentMode = .scaleAspectFit
        value.backgroundColor = .systemGray3.withAlphaComponent(0.3)
        value.clipsToBounds = true
        value.layer.cornerRadius = 20
        value.addTarget(self, action: #selector(addToFavouritesButtonPressed), for: .touchUpInside)
        return value
    }()

    private lazy var leagueImageView: UIImageView = {
        let value = UIImageView()
        value.contentMode = .scaleAspectFit
        value.backgroundColor = .systemGray3.withAlphaComponent(0.3)
        value.clipsToBounds = true
        value.layer.cornerRadius = 20
        return value
    }()

    private lazy var countryCodeLabel: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 18, weight: .medium)
        value.backgroundColor = .systemGray3.withAlphaComponent(0.3)
        value.contentMode = .center
        value.textAlignment = .center
        value.clipsToBounds = true
        value.layer.cornerRadius = 20
        return value
    }()

    private lazy var homeTeamImageView: UIImageView = {
        let value = UIImageView()
        value.contentMode = .scaleAspectFit
        value.clipsToBounds = true
        value.layer.cornerRadius = 12
        return value
    }()

    private lazy var guestTeamImageView: UIImageView = {
        let value = UIImageView()
        value.contentMode = .scaleAspectFit
        value.clipsToBounds = true
        value.layer.cornerRadius = 12
        return value
    }()

    private lazy var homeTeamNameLable: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 18, weight: .heavy)
        value.contentMode = .center
        value.textAlignment = .center
        value.numberOfLines = 2
        value.text = "No name"
        return value
    }()

    private lazy var guestTeamNameLable: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 18, weight: .heavy)
        value.contentMode = .center
        value.textAlignment = .center
        value.numberOfLines = 2
        value.text = "No name"
        return value
    }()

    private lazy var homeTotalScoreLabel: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 36, weight: .heavy)
        value.contentMode = .center
        value.textAlignment = .center
        value.text = "-"
        return value
    }()

    private lazy var guestTotalScoreLabel: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 36, weight: .heavy)
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
        return value
    }()

    private lazy var statusLabel: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: 12, weight: .medium)
        value.contentMode = .center
        value.textAlignment = .center
        value.text = "No status"
        return value
    }()

    // MARK: - Methods
    @objc private func addToFavouritesButtonPressed() {
        if buttonTogled == false {
            buttonTogled = true
            addToFavouritesButton.setImage(UIImage(systemName: "pin.fill"), for: .normal)
//            self.delegate?.saveToFavouritesButtonTapped(tappedForItem: self.tag)
        } else {
            buttonTogled = false
            addToFavouritesButton.setImage(UIImage(systemName: "pin"), for: .normal)
//            self.delegate?.deleteFromFavouritesButtonTapped(tappedForItem: self.tag)
        }
    }

    func configure(with gameModel: GameResponse) {
        let leagueImageURL = URL(string: gameModel.league?.logo ?? Constants.noImageURL)
        leagueImageView.kf.setImage(with: leagueImageURL)

        let homeTeamImageURL = URL(string: gameModel.teams?.home?.logo ?? Constants.noImageURL)
        homeTeamImageView.kf.indicatorType = .activity
        homeTeamImageView.kf.setImage(with: homeTeamImageURL)

        let guestTeamImageURL = URL(string: gameModel.teams?.away?.logo ?? Constants.noImageURL)
        guestTeamImageView.kf.indicatorType = .activity
        guestTeamImageView.kf.setImage(with: guestTeamImageURL)

        homeTeamNameLable.text = gameModel.teams?.home?.name
        guestTeamNameLable.text = gameModel.teams?.away?.name

        let formatedDate = DateFormaterManager.shared.formatDate(stringDate: gameModel.date ?? "")
        dateLabel.text = formatedDate

        statusLabel.text = gameModel.status?.long
        homeTotalScoreLabel.text = gameModel.scores?.home?.total?.description
        guestTotalScoreLabel.text = gameModel.scores?.away?.total?.description
        countryCodeLabel.text = gameModel.country?.code
    }
}

extension GameTableViewCell {
    private func setUpUI() {
        contentView.addSubview(myBackgroundView)
        myBackgroundView.addSubview(statusLabel)
        myBackgroundView.addSubview(homeTotalScoreLabel)
        myBackgroundView.addSubview(guestTotalScoreLabel)
        myBackgroundView.addSubview(addToFavouritesButton)
        myBackgroundView.addSubview(homeTeamImageView)
        myBackgroundView.addSubview(guestTeamImageView)
        myBackgroundView.addSubview(dateLabel)
        myBackgroundView.addSubview(leagueImageView)
        myBackgroundView.addSubview(homeTeamNameLable)
        myBackgroundView.addSubview(guestTeamNameLable)
        myBackgroundView.addSubview(countryCodeLabel)

        myBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(6)
        }

        countryCodeLabel.snp.makeConstraints {
            $0.height.width.equalTo(40)
            $0.leading.bottom.equalToSuperview().inset(4)
        }

        addToFavouritesButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.bottom.trailing.equalToSuperview().inset(4)
        }

        leagueImageView.snp.makeConstraints {
            $0.height.width.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(homeTeamImageView.snp.centerY)
        }

        homeTeamImageView.snp.makeConstraints {
            $0.height.width.equalToSuperview().dividedBy(2)
            $0.top.leading.equalToSuperview()
        }

        guestTeamImageView.snp.makeConstraints {
            $0.height.width.equalToSuperview().dividedBy(2)
            $0.top.trailing.equalToSuperview()
        }

        homeTeamNameLable.snp.makeConstraints {
            $0.top.equalTo(homeTeamImageView.snp.bottom).inset(6)
            $0.width.equalTo(homeTeamImageView)
            $0.height.equalTo(52)
            $0.centerX.equalTo(homeTeamImageView)
        }

        guestTeamNameLable.snp.makeConstraints {
            $0.top.equalTo(guestTeamImageView.snp.bottom).inset(6)
            $0.width.equalTo(guestTeamNameLable)
            $0.height.equalTo(52)
            $0.centerX.equalTo(guestTeamImageView)
        }

        homeTotalScoreLabel.snp.makeConstraints {
            $0.top.equalTo(homeTeamNameLable.snp.bottom)
            $0.centerX.equalTo(homeTeamImageView)
            $0.bottom.equalTo(dateLabel.snp.top)
            $0.width.equalTo(homeTeamImageView)

        }

        guestTotalScoreLabel.snp.makeConstraints {
            $0.top.equalTo(guestTeamNameLable.snp.bottom)
            $0.centerX.equalTo(guestTeamImageView)
            $0.bottom.equalTo(dateLabel.snp.top)
            $0.width.equalTo(guestTeamImageView)
        }

        statusLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }

        dateLabel.snp.makeConstraints {
            $0.bottom.equalTo(statusLabel.snp.top)
            $0.centerX.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
    }
}
