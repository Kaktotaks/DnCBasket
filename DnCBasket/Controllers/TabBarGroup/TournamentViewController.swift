//
//  TournamentsViewController.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 05.12.2022.
//

import UIKit
import SnapKit

class TournamentViewController: UIViewController {
    private var tournamentTableView: UITableView = {
        let value: UITableView = .init()
        value.separatorStyle = .none
        return value
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setUpTableView()
    }

    private func setUpTableView() {
        tournamentTableView.register(TeamPlaceTableViewCell.self, forCellReuseIdentifier: TeamPlaceTableViewCell.identifier)
        tournamentTableView.register(TournamentHeaderView.self, forHeaderFooterViewReuseIdentifier: TournamentHeaderView.idetifier)
        tournamentTableView.delegate = self
        tournamentTableView.dataSource = self
    }
}

extension TournamentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
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

//        cell.configure(with: gamesModel[indexPath.row])
        cell.selectionStyle = .none
        cell.positionLabel.text = "\(indexPath.row + 1)"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }

    // MARK: - Header setup
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TournamentHeaderView.idetifier) as? TournamentHeaderView
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
