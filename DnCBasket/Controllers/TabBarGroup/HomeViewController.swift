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
    private lazy var eventsSettingsView: UIView = {
        let value: UIView = .init()
        value.translatesAutoresizingMaskIntoConstraints = false
        return value
    }()
    
    private lazy var gamesTableView: UITableView = {
        let value: UITableView = .init()
        value.separatorStyle = .none
        return value
    }()
    
    private var gamesModel: [GameResponse] = []
    private var leaguesModels = [LeagueResponse]()

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
}

// MARK: - TableView setup
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        2
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            if section == 0 {
//                return 1
//            }

            return gamesModel.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            guard
//                let cell = gamesTableView.dequeueReusableCell(
//                    withIdentifier: LeaguesTableViewCell.identifier,
//                    for: indexPath)
//                    as? LeaguesTableViewCell
//            else {
//                return UITableViewCell()
//            }
//
//            cell.configure(with: leaguesModels)
//            cell.selectionStyle = .none
//            return cell
//        }

        guard
            let cell = gamesTableView.dequeueReusableCell(
                withIdentifier: GameTableViewCell.identifier,
                for: indexPath)
                as? GameTableViewCell
        else {
            return UITableViewCell()
        }

        cell.configure(with: gamesModel[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        400
    }
}

// MARK: - Setup UI components
extension HomeViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(gamesTableView)
        view.addSubview(eventsSettingsView)

        eventsSettingsView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        gamesTableView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
