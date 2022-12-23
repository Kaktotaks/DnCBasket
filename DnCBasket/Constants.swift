//
//  Constants.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 12.12.2022.
//

import UIKit

enum Constants {
    static let dncLabel = "D     С"
    static let loginButtonTitle = "Login"
    static let createButtonTitle = "Create account"
    static let enterAsGuestButtonTitle = "Enter as a guest"

    static let emailPlaceholderText = "Email address"
    static let passPlaceholderText = "Password"

    static let redColor = UIColor(red: 198 / 255, green: 60 / 255, blue: 83 / 255, alpha: 1.0)

    static let noImageURL = "https://us.123rf.com/450wm/koblizeek/koblizeek1902/koblizeek190200055/koblizeek190200055.jpg?ver=6"

    enum TemporaryAlertAnswers {
        static let gameAddedtoFavourites = "This game was successfully added to favourites!"
        static let gameRemovedFromFavourites = "This game removed from favourites!"
        static var somethingWentWrongAnswear = "Something went wrong:"
    }

    static let dayAndTimeDateFormat = "dd-MM-yyyy HH:mm"
}
