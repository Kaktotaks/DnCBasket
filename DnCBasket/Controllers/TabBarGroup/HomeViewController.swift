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
    private lazy var categorySwitcher = 0

    private lazy var eventsSettingsView: UIView = {
        let value: UIView = .init()
        value.translatesAutoresizingMaskIntoConstraints = false
        return value
    }()

    private lazy var categoriesCollectionView: UICollectionView = {
//        value.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: <#T##String#>)
        let layout: UICollectionViewFlowLayout = .init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 20, height: 20)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        let value = UICollectionView(frame: .zero, collectionViewLayout: layout)
        value.backgroundColor = .green
        value.translatesAutoresizingMaskIntoConstraints = false
        return value
    }()
    
    private lazy var gamesTableView: UITableView = {
        let value: UITableView = .init()
        value.separatorStyle = .none
        return value
    }()

    private lazy var filteredByButton: UIButton = {
        let value: UIButton = .init()
        value.setImage(UIImage(systemName: "checklist"), for: .normal)
        value.backgroundColor = Constants.redColor.withAlphaComponent(0.7)
        value.translatesAutoresizingMaskIntoConstraints = false
        return value
    }()
    
    private var gamesModel: [GameResponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setUpTableView()
        getGames()
        setupFilteredByButton()
        setUPNavItems(needed: true)
    }

    // MARK: - Methods
    private func setupFilteredByButton() {
        let categoriesMenu = UIMenu(title: "",
                                    children: [
            UIAction(title: "Leagues",
                     image: UIImage(systemName: "sportscourt")) { _ in
                         print("Leagues")
                         self.categorySwitcher = 0
                         self.categoriesCollectionView.reloadData()
            },
            UIAction(title: "Seasons",
                     image: UIImage(systemName: "calendar")) { _ in
                         print("Calendar")
                         self.categorySwitcher = 1
                         self.categoriesCollectionView.reloadData()
            }
                                    ]
        )

        filteredByButton.layer.cornerRadius = 4
        filteredByButton.menu = categoriesMenu
        filteredByButton.showsMenuAsPrimaryAction = true
    }
    
    private func setUpTableView() {
        gamesTableView.register(GameTableViewCell.self, forCellReuseIdentifier: GameTableViewCell.identifier)
        gamesTableView.delegate = self
        gamesTableView.dataSource = self

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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gamesModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        eventsSettingsView.addSubview(filteredByButton)
        eventsSettingsView.addSubview(categoriesCollectionView)

        eventsSettingsView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }

        filteredByButton.snp.makeConstraints {
            $0.leading.height.equalToSuperview()
            $0.width.equalTo(40)
        }

        categoriesCollectionView.snp.makeConstraints {
            $0.left.equalTo(filteredByButton.snp.right)
            $0.top.bottom.trailing.equalToSuperview()
        }
        
        gamesTableView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}
