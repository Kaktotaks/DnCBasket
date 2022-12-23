//
//  TeamsViewController.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 05.12.2022.
//

import UIKit

class TeamsViewController: BaseViewController {
    private var teamsCollectionView: UICollectionView!
    private var teamsModel: [TeamResponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getAllTeams()
    }

    // MARK: - functions
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        teamsCollectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: layout)
        teamsCollectionView.register(BaseCollectionViewCell.self,
                                forCellWithReuseIdentifier: BaseCollectionViewCell.identifier)
        teamsCollectionView.delegate = self
        teamsCollectionView.dataSource = self
        view.addSubview(teamsCollectionView)
    }

    private func getAllTeams() {
        ActivityIndicatorManager.shared.showIndicator(.basketballLoading)
        RestService.shared.getAllTeams { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let teams):
                self.teamsModel.removeAll()
                self.teamsModel.append(contentsOf: teams)
                DispatchQueue.main.async {
                    ActivityIndicatorManager.shared.hide()
                    self.teamsCollectionView.reloadData()
                }
            case .failure(let error):
                self.showErrorAlert(error.localizedDescription, controller: self)
            }
        }
    }
}

extension TeamsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        teamsModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BaseCollectionViewCell.identifier,
            for: indexPath) as? BaseCollectionViewCell
        else {
            return UICollectionViewCell()
        }

        cell.configure(with: teamsModel[indexPath.row])

        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: view.frame.width / 3.5, height: 140)
    }
}
