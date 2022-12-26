//
//  PickedGamesViewController.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 20.12.2022.
//

import UIKit
import SnapKit

class PickedGamesViewController: BaseViewController {
    // MARK: - Constants & Variables
    private lazy var pickedGamesTableView: UITableView = {
        let value: UITableView = .init()
        value.separatorStyle = .none
        return value
    }()

    private var pickedGames: [CDGame] = []

    // MARK: - UI life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setUpGamesTableView()
        configureNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.pickedGames = getGames()
    }

    // MARK: - Methods
    private func configureNavigationBar() {
        title = Constants.pickedGamesText
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: Constants.clearAllText,
            style: .plain,
            target: self,
            action: #selector(didTapClearAllButton))
    }

    @objc private func didTapClearAllButton() {
        MyCoreDataManager.shared.cdTryDeleteAllObjects(context: context) {
            self.getGames()
        }
    }

    private func getGames() -> [CDGame] {
       // Fetch data from Core Data to displayin the table View
       do {
           self.pickedGames = try context.fetch(CDGame.fetchRequest())
           DispatchQueue.main.async {
               self.pickedGamesTableView.reloadData()
           }
       } catch {
           print("An error while fetch some data from Core Data")
       }

        return pickedGames
   }

    private func setUpGamesTableView() {
        view.addSubview(pickedGamesTableView)

        pickedGamesTableView.delegate = self
        pickedGamesTableView.dataSource = self
        pickedGamesTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.pickedGamesTableView.register(GameTableViewCell.self, forCellReuseIdentifier: GameTableViewCell.identifier)
    }
}

// MARK: - Work with tableView DataSource/Delegate methods
extension PickedGamesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pickedGames.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: GameTableViewCell.identifier
            ) as? GameTableViewCell
        else {
            return UITableViewCell()
        }

        cell.selectionStyle = .none
        cell.configure(with: pickedGames[indexPath.row])
        cell.addToFavouritesButton.isHidden = true

        return cell
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        // create swipe action
        let action = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in

            // Wich present to remove
            let gamesToRemove = self.pickedGames[indexPath.row]
            // Remove the games + Save the data + Re-fetch the data
            MyCoreDataManager.shared.deleteCoreDataObjct(object: gamesToRemove, context: self.context) {
                self.getGames()
            }
        }

        return UISwipeActionsConfiguration(actions: [action])
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        400
    }
}
