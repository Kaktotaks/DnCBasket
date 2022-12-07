//
//  StringExtension.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 06.12.2022.
//

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
