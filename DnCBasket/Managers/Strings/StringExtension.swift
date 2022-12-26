//
//  StringExtension.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 26.12.2022.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
