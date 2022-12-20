//
//  HomeViewController.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 05.12.2022.
//

 // swiftlint: disable all

import UIKit
import SnapKit

class HomeViewController: BaseViewController {
    // MARK: - Constants & Variables
    private lazy var gamesTableView: UITableView = {
        let value: UITableView = .init()
        value.separatorStyle = .none
        return value
    }()

    private var gamesModel: [GameResponse] = []
    private var leaguesModels = [LeagueResponse]()
    private lazy var upButton: UIButton = {
        let value: UIButton = .init()
        value.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        value.tintColor = .label
        value.contentMode = .scaleAspectFit
        value.clipsToBounds = true
        value.layer.cornerRadius = 20
        
        value.addTarget(self, action: #selector(upButtonPressed), for: .touchUpInside)
        value.backgroundColor = .systemGray3.withAlphaComponent(0.5)
        return value
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setUpTableView()
        getGames()
        setUPNavItems(needed: true)
    }

    // MARK: - Methods
    private func setUpTableView() {
        gamesTableView.register(GameTableViewCell.self, forCellReuseIdentifier: GameTableViewCell.identifier)
        gamesTableView.register(LeaguesTableViewCell.self, forCellReuseIdentifier: LeaguesTableViewCell.identifier)
        gamesTableView.delegate = self
        gamesTableView.dataSource = self
    }
    
    private func getLeagues() {
        
    }
    
    private func getGames() {
        ActivityIndicatorManager.shared.showIndicator(.basketballLoading)

        RestService.shared.getAllGames { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let games):
                self.gamesModel.append(contentsOf: games)
                DispatchQueue.main.async {
                    ActivityIndicatorManager.shared.hide()
                    self.gamesTableView.reloadData()
                }
            case .failure(let error):
                let somethingWentWrongAlert = MyAlertManager.shared.presentTemporaryInfoAlert(
                    title: Constants.TemporaryAlertAnswers.somethingWentWrongAnswear,
                    message: error.localizedDescription,
                    preferredStyle: .actionSheet,
                    forTime: 10.0)
                DispatchQueue.main.async {
                    ActivityIndicatorManager.shared.hide()
                    self.present(somethingWentWrongAlert, animated: true)
                }
            }
        }
    }
    
    @objc private func upButtonPressed() {
        let topRow = IndexPath(row: 0, section: 0)
        
        gamesTableView.scrollToRow(at: topRow,
                                   at: .top,
                                   animated: true
        )
    }
}

// MARK: - TableView setup
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 0 {
                return 1
            }

            return gamesModel.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard
                let cell = gamesTableView.dequeueReusableCell(
                    withIdentifier: LeaguesTableViewCell.identifier,
                    for: indexPath)
                    as? LeaguesTableViewCell
            else {
                return UITableViewCell()
            }

//            cell.configure(with: leaguesModels)
            
            cell.selectionStyle = .none
            return cell
        }

        guard
            let cell = gamesTableView.dequeueReusableCell(
                withIdentifier: GameTableViewCell.identifier,
                for: indexPath)
                as? GameTableViewCell
        else {
            return UITableViewCell()
        }

        cell.configure(with: gamesModel[indexPath.row])
        cell.delegate = self
        cell.tag = indexPath.row
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 180
        }
        return 400
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        upButtonAppearance(scrollView, upButton: upButton)
    }
}

// MARK: - Setup UI components
extension HomeViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(gamesTableView)
        view.addSubview(upButton)
        
        gamesTableView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        upButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            $0.centerX.equalToSuperview()
        }
    }
}

extension HomeViewController: GameTableViewCellDelegate {
    func saveToPickedButtonTapped(tappedForItem item: Int) {
        let game = gamesModel[item]
        let cdGame = CDGame(context: self.context)
        cdGame.homeTeamName = game.teams?.home?.name
        cdGame.homeTotalScore = game.teams?.home?.total?.description
        cdGame.homeTeamImageURL = game.teams?.home?.logo
        cdGame.guestTeamName = game.teams?.away?.name
        cdGame.guestTotalScore = game.teams?.away?.total?.description
        cdGame.guestTeamImageURL = game.teams?.away?.logo
        cdGame.countryCode = game.country?.code
        cdGame.status = game.status?.long
        cdGame.date = game.date
        cdGame.leagueImageURL = game.league?.logo
        

        // Save in Core Data action
        MyCoreDataManager.shared.cdSave(self.context)

        let alert = MyAlertManager.shared.presentTemporaryInfoAlert(
            title: "Article Added",
            message: nil,
            preferredStyle: .actionSheet,
            forTime: 1.0
        )

        present(alert, animated: true)
    }
}
