//
//  CreateAccountViewController.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 06.12.2022.
//

import UIKit
import SkyFloatingLabelTextField
import FirebaseAuth

class CreateAccountViewController: UIViewController {
    private enum Constants {
        static let emailPlaceholderText = "Enter your email"
        static let passPlaceholderText = "Create your password"
    }

    private lazy var registrationLabel: UILabel = {
        let value: UILabel = .init()
        value.text = "Registration"
        value.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        value.textAlignment = .center
        return value
    }()

    private lazy var emailTextField: SkyFloatingLabelTextField = {
        let value = SkyFloatingLabelTextField()
        value.placeholder = Constants.emailPlaceholderText
        value.title = "Email"
        value.selectedTitleColor = .systemGray
        value.font = UIFont.systemFont(ofSize: 20)
        value.autocapitalizationType = .none
        value.leftViewMode = .always
        return value
    }()

    private lazy var passwordTextField: SkyFloatingLabelTextField = {
        let value = SkyFloatingLabelTextField()
        value.placeholder = Constants.passPlaceholderText
        value.title = "Password"
        value.selectedTitleColor = .systemGray
        value.font = UIFont.systemFont(ofSize: 20)
        value.autocapitalizationType = .none
        value.leftViewMode = .always
        return value
    }()

    private lazy var createAccountButton: UIButton = {
        let value: UIButton = .init()
        value.backgroundColor = .systemFill.withAlphaComponent(0.5)
        value.addTarget(self, action: #selector(createAccountButtonPressed), for: .touchUpInside)
        value.setTitleColor(.white, for: .normal)
        value.setTitle("Create an account", for: .normal)
        value.layer.cornerRadius = 10
        value.layer.borderWidth = 1
        value.layer.borderColor = UIColor.systemOrange.cgColor
        return value
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        passwordTextField.delegate = self
        setupUI()
    }

    // MARK: - Functions
    @objc private func backButtonTapped() {
            dismiss(animated: true, completion: nil)
    }

    @objc private func createAccountButtonPressed(sender: UIButton!) {
        guard
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
        else {
            print(print("Missing data in Email/Password field."))
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self]_, error in
            guard let self = self else { return }

            if error == nil {
                let successAlert = MyAlertManager.shared.presentTemporaryInfoAlert(
                    title: "Well done",
                    message: "You have just created a new account. Go back to login.",
                    preferredStyle: .actionSheet,
                    forTime: 30
                )

                successAlert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(successAlert, animated: true, completion: nil)
            } else {
                print("Registration error: \(error?.localizedDescription)")
                let errorAlert = MyAlertManager.shared.presentTemporaryInfoAlert(
                    title: "Registration error:",
                    message: error?.localizedDescription,
                    preferredStyle: .actionSheet,
                    forTime: 5
                )

                self.present(errorAlert, animated: true, completion: nil)
            }
        }
    }

    func checkEmail(email: String) {
        let response = Validation.shared.validate(values: (ValidationType.email, email))

        switch response {
        case .success:
            print("success")
            break
        case .failure(_, let message):
            print(message.localized())
        }
    }

    func checkPassword(password: String) {
        let response = Validation.shared.validate(values: (ValidationType.password, password))

        switch response {
        case .success:
            print("success")
            break
        case .failure(_, let message):
            print(message.localized())
        }
    }
}

extension CreateAccountViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") + string
        let responce: String
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            responce = String(text[text.startIndex..<end])
        } else {
            responce = text
        }

        textField.text = responce

        if emailTextField.isEditing {
            checkEmail(email: responce)
        } else if passwordTextField.isEditing {
            checkPassword(password: responce)
        }

        return false
    }
}

// MARK: - Constraints extension
extension CreateAccountViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground.withAlphaComponent(0.8)
        view.addSubview(registrationLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(createAccountButton)

        registrationLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.top.equalToSuperview().inset(30)
            $0.height.equalTo(40)
        }

        emailTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.top.equalTo(registrationLabel).inset(56)
            $0.height.equalTo(40)
        }

        passwordTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.top.equalTo(emailTextField).inset(50)
            $0.height.equalTo(40)
        }

        createAccountButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.top.equalTo(passwordTextField).inset(70)
            $0.height.equalTo(40)
        }
    }
}
