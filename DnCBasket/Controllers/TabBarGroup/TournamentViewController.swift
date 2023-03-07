//
//  TournamentsViewController.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 05.12.2022.
//

import UIKit
import SnapKit

class TournamentViewController: BaseViewController {
    // MARK: - Constants & Variables
    private var tournamentTableView: UITableView = {
        let value: UITableView = .init()
        value.separatorStyle = .none
        return value
    }()

    private var conferencesModel: [[TournamentResponse]] = [[]]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setUpTableView()
    }

    // MARK: - Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getAllStandings()
    }

    private func setUpTableView() {
        tournamentTableView.register(TeamPlaceTableViewCell.self, forCellReuseIdentifier: TeamPlaceTableViewCell.identifier)
        tournamentTableView.register(
            TournamentHeaderView.self,
            forHeaderFooterViewReuseIdentifier: TournamentHeaderView.idetifier
        )
        tournamentTableView.delegate = self
        tournamentTableView.dataSource = self
    }

    private func getAllStandings() {
        ActivityIndicatorManager.shared.showIndicator(.basketballLoading)
        RestService.shared.getAllStandings { [weak self] result in
            guard let self = self else { return }

            switch result {
                case .success(let standings):
                    self.conferencesModel.removeAll()
                    self.conferencesModel.append(contentsOf: standings)
                    DispatchQueue.main.async {
                        ActivityIndicatorManager.shared.hide()
                        self.tournamentTableView.reloadData()
                        self.checkIfModelIsEmpty(controller: self, model: standings)
                    }
                case .failure(let error):
                    self.showErrorAlert(error.localizedDescription, controller: self)
            }
        }
    }
}

// MARK: - UITableView Delegate/DataSource
extension TournamentViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        conferencesModel.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfTeams = 0

        for teams in conferencesModel {
            numberOfTeams = teams.count
        }

        return numberOfTeams
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tournamentTableView.dequeueReusableCell(
                withIdentifier: TeamPlaceTableViewCell.identifier,
                for: indexPath)
                as? TeamPlaceTableViewCell
        else {
            return UITableViewCell()
        }

        for conference in conferencesModel {
            cell.configure(with: conference[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    // MARK: - Header setup
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: TournamentHeaderView.idetifier
        ) as? TournamentHeaderView
        let model = conferencesModel.first?.first
        header?.configure(model: model)
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        100
    }
}

extension TournamentViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tournamentTableView)

        tournamentTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
}
