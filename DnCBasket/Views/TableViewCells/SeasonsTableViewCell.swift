//
//  SeasonsTableViewCell.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 21.12.2022.
//

import UIKit

protocol SeasonsTableViewCellDelegate: AnyObject {
    func sendSeasonData(tappedForItem item: Int)
}

class SeasonsTableViewCell: UITableViewCell {
    // MARK: - Constants and Variables
    static let identifier = "SeasonsTableViewCell"
    private var collectionView: UICollectionView!
    private var seasonsModels = [Seasons]()
    weak var delegate: SeasonsTableViewCellDelegate?

    override func layoutSubviews() {
        super.layoutSubviews()

        configureCollectionView()
    }

    func configure(with models: [Seasons]) {
        self.seasonsModels = models
        collectionView?.reloadData()
    }

    // MARK: - Methods
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: contentView.frame.size.height),
            collectionViewLayout: layout)
        collectionView.register(SeasonsCollectionViewCell.self,
                                forCellWithReuseIdentifier: SeasonsCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        contentView.addSubview(collectionView)
    }
}

// MARK: - CollectionView Delegate/DataSource methods
extension SeasonsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        seasonsModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SeasonsCollectionViewCell.identifier,
                for: indexPath) as? SeasonsCollectionViewCell
        else {
            return UICollectionViewCell()
        }

        cell.configure(with: seasonsModels[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.sendSeasonData(tappedForItem: indexPath.last ?? 0)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: 140, height: 30)
    }
}
