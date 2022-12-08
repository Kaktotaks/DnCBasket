//
//  FireBaseManager.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 08.12.2022.
//

import FirebaseAuth
import UIKit

class FireBaseManager {
    static let shared: FireBaseManager = .init()

    private init() {}

    func createAccount(email: String, password: String, viewController: UIViewController) {
            let validatedEmailAndPassword = Validator.shared.validate(values:
                                                                        (ValidationType.email, email),
                                                                      (ValidationType.password, password)
            )

            switch validatedEmailAndPassword {
            case .success:
                Auth.auth().createUser(withEmail: email, password: password)

                let successAlert = MyAlertManager.shared.presentTemporaryInfoAlert(
                    title: "Well done",
                    message: "You have just created a new account. Go back to login.",
                    preferredStyle: .actionSheet,
                    forTime: .infinity
                )

                successAlert.addAction(UIAlertAction(title: "OK", style: .default) {_ in
                    viewController.dismiss(animated: true)
                })

                viewController.present(successAlert, animated: true)
            case .failure(_, let errorMessage):
                let errorAlert = MyAlertManager.shared.presentTemporaryInfoAlert(
                    title: "Registration error:",
                    message: errorMessage.localized(),
                    preferredStyle: .actionSheet,
                    forTime: 5
                )

                viewController.present(errorAlert, animated: true)
            }
    }
}
