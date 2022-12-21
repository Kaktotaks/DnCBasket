//
//  YearsTableViewCell.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 21.12.2022.
//

import UIKit

class YearsTableViewCell: UITableViewCell {
        // MARK: - Constants and Variables
        static let identifier = "YearsTableViewCell"
        private var collectionView: UICollectionView!
        private var yearsModels = [Seasons]()

        override func layoutSubviews() {
            super.layoutSubviews()

            configureCollectionView()
        }

        func configure(with models: [Seasons]) {
            self.yearsModels = models
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
            collectionView.register(YearsCollectionViewCell.self,
                                    forCellWithReuseIdentifier: YearsCollectionViewCell.identifier)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.showsHorizontalScrollIndicator = false
            contentView.addSubview(collectionView)
        }

    }

    extension YearsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //        leaguesModels.count
            10
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard
                let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: YearsCollectionViewCell.identifier,
                for: indexPath) as? YearsCollectionViewCell
            else {
                return UICollectionViewCell()
            }

//            cell.configure(with: yearsModels[indexPath.row])

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
            CGSize(width: 140, height: 30)
        }
}
