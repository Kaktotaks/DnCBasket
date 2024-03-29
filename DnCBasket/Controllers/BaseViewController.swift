//
//  BaseViewController.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 05.12.2022.
//

import UIKit
import SnapKit
import FirebaseAuth

class BaseViewController: UIViewController {
    // swiftlint:disable force_cast
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // swiftlint:enable force_cast

    var user = FirebaseAuth.Auth.auth().currentUser

    func setUPExitleftBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "door.left.hand.open"),
            style: .plain,
            target: self,
            action: #selector(logOutButtonTapped)
        )
    }

    // MARK: In developing...
    func setupLanguageRightBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "character.bubble"),
            style: .plain,
            target: self,
            action: nil
        )

        let languagesMenu = UIMenu(
            title: "",
            children: [
                UIAction(title: "en",
                         image: nil) { _ in
                             debugPrint("en - tappad")
                             Constants.currentLanguage = "en"
                },
                UIAction(title: "uk",
                         image: nil) { _ in
                             debugPrint("uk - tappad")
                             Constants.currentLanguage = "uk"
                }
            ]
        )

        navigationItem.rightBarButtonItem?.menu = languagesMenu
    }

    func setCurrentLeagueAndSeasonTitle(showTeamIfNeed: Bool = false) {
        var configuredTitle = ""

        let currentSeason = APIConstants.currentSeson
        let currentLeague = APIConstants.currentLeagueName
        let currentTeam = APIConstants.currentTeamName

        if let seasonKey = currentSeason {
            configuredTitle = "\(seasonKey)"
        }

        if let leagueKey = currentLeague {
            configuredTitle = "\(configuredTitle)/\(leagueKey)"
        }

        if showTeamIfNeed {
            if let teamKey = currentTeam {
                configuredTitle = "\(configuredTitle)/\(teamKey)"
            }
        }

        self.navigationItem.title = configuredTitle
    }

    // MARK: - Alert that shows different types of error (Bad network connection included)
    func showErrorAlert(_ message: String, controller: UIViewController) {
        let errorAlert = MyAlertManager.shared.presentTemporaryInfoAlert(
            title: Constants.AlertAnswers.somethingWentWrongAnswear,
            message: message,
            preferredStyle: .actionSheet,
            forTime: 10.0)
        DispatchQueue.main.async {
            ActivityIndicatorManager.shared.hide()
            controller.present(errorAlert, animated: true)
        }
    }

//    @objc private func languageRightBarButtonTapped() {
//        let categoriesMenu = UIMenu(
//            title: "",
//            children: [
//                UIAction(title: "en",
//                         image: nil) { _ in
//                             debugPrint("en - tappad")
//                         },
//                UIAction(title: "uk",
//                         image: nil) { _ in
//                             debugPrint("uk - tappad")
//                         }
//            ]
//        )
//    }

    // MARK: - Exit from account
    @objc func logOutButtonTapped() {
        FireBaseManager.shared.signOut {
            MyCoreDataManager.shared.cdTryDeleteAllObjects(entityName: .CDGame, context: self.context) {}
            MyCoreDataManager.shared.cdTryDeleteAllObjects(entityName: .CDPhoto, context: self.context) {}

            self.dismiss(animated: true, completion: nil)
        }
    }

    // MARK: - Rout to TabBarController
    func goToTapBar(controller: UIViewController, animated: Bool = true) {
        let tapBar = UINavigationController(rootViewController: TabBarController())
        tapBar.modalPresentationStyle = .fullScreen
        tapBar.modalTransitionStyle = .flipHorizontal
        controller.present(tapBar, animated: animated)
    }

    // MARK: - Rout to CreateAccountViewController
    func goToCreateAccVC(controller: UIViewController) {
        let createAccVC = CreateAccountViewController()
        let navController = UINavigationController(rootViewController: createAccVC)
        if let sheet = navController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }

        controller.present(navController, animated: true)
    }

    // MARK: - Rout to PickedGamesViewController
    func goToPickedGames(controller: UIViewController) {
        let pickedGamseVC = PickedGamesViewController()
        let navController = UINavigationController(rootViewController: pickedGamseVC)
        if let sheet = navController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }

        controller.present(navController, animated: true)
    }

    // MARK: - Rout to HomeViewController
    func goToHomeViewController(controller: UIViewController) {
        let homeVC = HomeViewController()
        let navController = UINavigationController(rootViewController: homeVC)
        if let sheet = navController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }

        controller.present(navController, animated: true)
    }

    // MARK: - Alert about added game
    func showGameAddedAlert(controller: UIViewController) {
        let alert = MyAlertManager.shared.presentTemporaryInfoAlert(
            title: Constants.AlertAnswers.gameAdded,
            message: nil,
            preferredStyle: .actionSheet,
            forTime: 3.0
        )
        controller.present(alert, animated: true)
    }

    // MARK: - Show user information that collection of Codable object is empty
    func checkIfModelIsEmpty(controller: UIViewController, model: [Codable]) {
        let alert = MyAlertManager.shared.presentTemporaryInfoAlert(
            title: Constants.AlertAnswers.noDataByThisParametrs,
            message: nil,
            preferredStyle: .actionSheet,
            forTime: 3.0
        )

        if model.isEmpty {
            controller.present(alert, animated: true)
        }
    }

    // MARK: - Alert for non registered users
    func showAlertToCreateAccount(controller: UIViewController) {
        let actions: [MyAlertManager.Action] = [
            .init(title: Constants.cancelText, style: .cancel),
            .init(title: Constants.goToRegistration, style: .default) {
                controller.dismiss(animated: true)
            }
        ]

        let alert = MyAlertManager.shared.presentAlertWithOptions(
            title: Constants.AlertAnswers.needAnAccountAnswear,
            message: nil,
            actions: actions,
            dismissActionTitle: nil)
        controller.present(alert, animated: true)
    }

    // MARK: - Configure appearance upButton
    func upButtonAppearance(_ scrollView: UIScrollView, upButton: UIButton) {
        DispatchQueue.main.async {
            let startPoint = scrollView.contentOffset.y
            let scrollHeight = scrollView.frame.height

            if startPoint >= abs(scrollHeight * 3) {
                upButton.isHidden = false
            } else {
                upButton.isHidden = true
            }
        }
    }
}
