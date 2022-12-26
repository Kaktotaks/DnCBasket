//
//  Constants.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 12.12.2022.
//

import UIKit

enum Constants {
    static let dncLabel = "D     С"
    static let homeTabBarTitle = "Home".localized()
    static let tournamentTabBarTitle = "Tournament".localized()
    static let teamsTabBarTitle = "Teams".localized()
    static let accountTabBarTitle = "Account".localized()
    static let gamesPlayedTitle = "GP".localized()
    static let wictoriesTitle = "W".localized()
    static let lossesTitle = "L".localized()
    static let totalPointsTitle = "TP".localized()

    static let loginButtonTitle = "Login".localized()
    static let createButtonTitle = "Create account".localized()
    static let enterAsGuestButtonTitle = "Enter as a guest".localized()

    static let emailTitleText = "Email".localized()
    static let emailPlaceholderText = "Email address".localized()
    static let passPlaceholderText = "Password".localized()
    static let createAccount = "Create an account".localized()
    static let registrationText = "Registration".localized()

    static let cancelText = "Cancel".localized()
    static let libraryText = "Library".localized()
    static let cameraText = "Camera".localized()
    static let pickaPhotoText = "Pick a photo".localized()
    static let choosePictureText = "Choose a picture from Camera or Library".localized()
    static let pickedGamesText = "Picked Games 📌".localized()
    static let clearAllText = "Clear all".localized()
    static let goToRegistration = "Go to registration".localized()

    static let redColor = UIColor(red: 198 / 255, green: 60 / 255, blue: 83 / 255, alpha: 1.0)

    static let noImageURL = "https://us.123rf.com/450wm/koblizeek/koblizeek1902/koblizeek190200055/koblizeek190200055.jpg?ver=6"

    enum AlertAnswers {
        static let gameAdded = "Game was successfuly added to Picked".localized()
        static var somethingWentWrongAnswear = "Something went wrong:".localized()
        static var needToCreateAnAccountAnswear = "😩 We are sorry, but you need to create an account to use this functionality".localized()
        static var wellDoneTitle = "Well done 🥳".localized()
        static var successFullAccountCreationTitle = "You have just created a new account. Go back to login.".localized()
        static var registrationErrorTitle = "❌ Registration error:".localized()
        static var logInErrorTitle = "❌ Log in error!".localized()
    }

    static let dayAndTimeDateFormat = "dd-MM-yyyy HH:mm"
}
