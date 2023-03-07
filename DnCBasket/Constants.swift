//
//  Constants.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 12.12.2022.
//

import UIKit

enum Constants {
    static var currentLanguage = "en"

    static let dncLabel = "D     С"
    static let homeTabBarTitle = "homeTitle".localizedByLang()
    static let tournamentTabBarTitle = "tournamentTitle".localizedByLang()
    static let teamsTabBarTitle = "teamsTitle".localizedByLang()
    static let accountTabBarTitle = "accountTitle".localizedByLang()
    static let gamesPlayedTitle = "gamesPlayed".localizedByLang()
    static let wictoriesTitle = "victories".localizedByLang()
    static let lossesTitle = "loses".localizedByLang()
    static let totalPointsTitle = "totalPoints".localizedByLang()

    static let loginButtonTitle = "loginTitle".localizedByLang()
    static let createButtonTitle = "createAccount".localizedByLang()
    static let enterAsGuestButtonTitle = "enterAsAGuest".localizedByLang()

    static let emailTitleText = "emailText".localizedByLang()
    static let emailPlaceholderText = "emailAddress".localizedByLang()
    static let passPlaceholderText = "passwordText".localizedByLang()
    static let createAccount = "createAccount".localizedByLang()
    static let registrationText = "registration".localizedByLang()

    static let cancelText = "cancel".localizedByLang()
    static let libraryText = "library".localizedByLang()
    static let cameraText = "camera".localizedByLang()
    static let pickaPhotoText = "pickPhoto".localizedByLang()
    static let choosePictureText = "cameraOrLibrary".localizedByLang()
    static let pickedGamesText = "pickedGamesTitle".localizedByLang()
    static let clearAllText = "clearAll".localizedByLang()
    static let goToRegistration = "goToRegistration".localizedByLang()

    static let redColor = UIColor(red: 198 / 255, green: 60 / 255, blue: 83 / 255, alpha: 1.0)

    static let noImageURL = "https://us.123rf.com/450wm/koblizeek/koblizeek1902/koblizeek190200055/koblizeek190200055.jpg?ver=6"

    enum AlertAnswers {
        static let gameAdded = "gameAddedToPicked".localizedByLang()
        static var somethingWentWrongAnswear = "somethingWentWrong".localizedByLang()
        static var needAnAccountAnswear = "needToCreateAccount".localizedByLang()
        static var wellDoneTitle = "wellDone".localizedByLang()
        static var successFullAccountCreationTitle = "newAccountCreated".localizedByLang()
        static var registrationErrorTitle = "registrationError".localizedByLang()
        static var logInErrorTitle = "logInError".localizedByLang()
        static var noDataByThisParametrs = "noInformation".localizedByLang()
    }

    static let dayAndTimeDateFormat = "dd-MM-yyyy HH:mm"
}
