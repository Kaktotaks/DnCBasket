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

    private var gamesModel: [GameResponse] = []
    private var leaguesModels: [LeagueResponse] = []
    private var seasonsModels: [Seasons] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setUpTableView()
        getLeagues()
        getGames()
        setUPNavItems(needed: true)
    }

    // MARK: - Methods
    private func setUpTableView() {
        gamesTableView.register(GameTableViewCell.self, forCellReuseIdentifier: GameTableViewCell.identifier)
        gamesTableView.register(LeaguesTableViewCell.self, forCellReuseIdentifier: LeaguesTableViewCell.identifier)
        gamesTableView.register(SeasonsTableViewCell.self, forCellReuseIdentifier: SeasonsTableViewCell.identifier)
        gamesTableView.delegate = self
        gamesTableView.dataSource = self
    }

    private func getLeagues() {
        ActivityIndicatorManager.shared.showIndicator(.basketballLoading)
        
        RestService.shared.getAllleagues() { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let leagues):
                self.leaguesModels.append(contentsOf: leagues)
                
                guard let seasons = leagues.first?.seasons else { return } // temp desision
                self.seasonsModels.append(contentsOf: seasons)
                DispatchQueue.main.async {
                    ActivityIndicatorManager.shared.hide()
                    self.gamesTableView.reloadData()
                }
            case .failure(let error):
                self.showErrorAlert(error.localizedDescription, controller: self)
            }
        }
    }

    // relocate to baseVC
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
                self.showErrorAlert(error.localizedDescription, controller: self)
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
        3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 0 || section == 1 {
                return 1
            }

            return gamesModel.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MARK: Set - LeaguesTableViewCell
        if indexPath.section == 0 {
            guard
                let cell = gamesTableView.dequeueReusableCell(
                    withIdentifier: LeaguesTableViewCell.identifier,
                    for: indexPath)
                    as? LeaguesTableViewCell
            else {
                return UITableViewCell()
            }

            cell.configure(with: leaguesModels)
            return cell
        } else if indexPath.section == 1 { // MARK: Set - YearsTableViewCell
            guard
                let cell = gamesTableView.dequeueReusableCell(
                    withIdentifier: SeasonsTableViewCell.identifier,
                    for: indexPath)
                    as? SeasonsTableViewCell
            else {
                return UITableViewCell()
            }

          cell.configure(with: seasonsModels)
            return cell
        }

        // MARK: Set - GameTableViewCell
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
        } else if indexPath.section == 1 {
            return 40
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

// MARK: - Set custom delegate method
extension HomeViewController: GameTableViewCellDelegate {
    func saveToPickedButtonTapped(tappedForItem item: Int) {
        let game = gamesModel[item]

        if self.user != nil {
            MyCoreDataManager.shared.saveGameToPicked(gameAPIModel: game, context: self.context) {
                self.showGameAddedAlert(vc: self)
            }
        } else {
            self.showAlertToCreateAccount(vc: self)
        }
    }
}
