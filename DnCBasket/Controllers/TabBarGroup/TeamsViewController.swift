//
//  TeamsViewController.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 05.12.2022.
//

import UIKit

class TeamsViewController: UIViewController {
    private var teamsCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureCollectionView()
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
}

extension TeamsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        teamsModels.count - set all teams from league and season from HomeVC
        20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BaseCollectionViewCell.identifier,
            for: indexPath) as? BaseCollectionViewCell
        else {
            return UICollectionViewCell()
        }

//        cell.configure(with: leaguesModels[indexPath.row])

//        if indexPath.row == 0 {
//            cell.hourLabel.text = "Now"
//        }

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
