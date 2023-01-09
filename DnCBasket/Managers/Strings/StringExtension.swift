//
//  StringExtension.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 26.12.2022.
// swiftlint: disable all

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }

    func localizedByLang() -> String {
        let path = Bundle.main.path(forResource: Constants.currentLanguage, ofType: "lproj")
        debugPrint("Locale path is: \(path)")
        let bundle = Bundle(path: path!)

        return NSLocalizedString(
            self,
            tableName: nil,
            bundle: bundle!,
            value: self,
            comment: self
        )
    }
}
