//
//  LeaguesTableViewCell.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 14.12.2022.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {
    // MARK: - Constants and Variables
    static let identifier = "LeaguesTableViewCell"
    private var collectionView: UICollectionView!
    private var leaguesModels: [LeagueResponse] = []

    override func layoutSubviews() {
        super.layoutSubviews()

        configureCollectionView()
    }

    func configure(with models: [LeagueResponse]) {
        self.leaguesModels = models
        collectionView?.reloadData()
    }

    // MARK: - functions
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height),
            collectionViewLayout: layout)
        collectionView.register(BaseCollectionViewCell.self,
                                forCellWithReuseIdentifier: BaseCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        contentView.addSubview(collectionView)
    }

}

extension LeaguesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        leaguesModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BaseCollectionViewCell.identifier,
            for: indexPath) as? BaseCollectionViewCell
        else {
            return UICollectionViewCell()
        }

        cell.configureLeague(with: leaguesModels[indexPath.row])

        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 140, height: 140)
    }
}
