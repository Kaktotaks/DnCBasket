//
//  UserInfoTableViewCell.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 19.12.2022.
//

import UIKit
import SnapKit

class UserInfoTableViewCell: UITableViewCell {
    static let identifier = "UserInfoTableViewCell"

    private lazy var dataTypeLabel: UILabel = {
        let value: UILabel = .init()
        value.textColor = .lightGray
        value.font = .systemFont(ofSize: 14, weight: .semibold)
        value.contentMode = .left
        value.text = "SomeData"
        return value
    }()

    private lazy var usersAnswerLabel: UILabel = {
        let value: UILabel = .init()
        value.font = .systemFont(ofSize: 18, weight: .regular)
        value.numberOfLines = 2
        value.contentMode = .left
        value.text = "SomeAnswear"
        return value
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        setUpUI()
    }

//    func configure(with userData: UserData) {
//        self.dataTypeLabel.text = userData.dataType
//        self.usersAnswerLabel.text = userData.usersAnswer
//    }
}

extension UserInfoTableViewCell {
    private func setUpUI() {
        contentView.addSubview(dataTypeLabel)
        contentView.addSubview(usersAnswerLabel)

        dataTypeLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(20)
        }

        usersAnswerLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(20)
        }
    }
}
