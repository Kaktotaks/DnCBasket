//
//  ProfileHeaderTableViewCell.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 19.12.2022.
//

import UIKit
import SnapKit

protocol AccountHeaderTableViewCellDelegate: AnyObject {
    func pickImage()
}

class AccountHeaderTableViewCell: UITableViewCell {
    static let identifier = "AccountHeaderTableViewCell"

    lazy var userImageView: UIImageView = {
        let value: UIImageView = .init()
        value.contentMode = .scaleAspectFill
        value.image = UIImage(named: "profileImage")
        value.clipsToBounds = true
        return value
    }()

    private lazy var changePhotoButton: UIButton = {
        let value: UIButton = .init()
        value.backgroundColor = .systemGray3
        value.addTarget(self, action: #selector(changePhotoButtonPressed), for: .touchUpInside)
        value.setImage(UIImage(systemName: "photo.on.rectangle.angled"), for: .normal)
        value.layer.cornerRadius = 10
        value.tintColor = .label
        return value
    }()

    weak var delegate: AccountHeaderTableViewCellDelegate?

    @objc private func changePhotoButtonPressed() {
        self.delegate?.pickImage()
    }

    override func layoutSubviews() {
        super .layoutSubviews()

        setUpUI()
    }

    func configureCoreDataPhotos(image: UIImage?) {
        userImageView.image = image
        }
}

extension AccountHeaderTableViewCell {
    private func setUpUI() {
        contentView.addSubview(userImageView)
        contentView.addSubview(changePhotoButton)

        userImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        userImageView.layer.cornerRadius = userImageView.frame.size.width / 2

        changePhotoButton.snp.makeConstraints {
            $0.top.equalTo(userImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(30)
        }
    }
}
