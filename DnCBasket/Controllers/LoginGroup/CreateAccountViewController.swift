//
//  CreateAccountViewController.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 06.12.2022.
//

import UIKit
import SkyFloatingLabelTextField

class CreateAccountViewController: UIViewController {
    private enum Constants {
        static let emailPlaceholderText = "Enter your email"
        static let passPlaceholderText = "Create your password"
        static let redColor = UIColor(red: 198 / 255, green: 60 / 255, blue: 83 / 255, alpha: 1.0)
    }

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
        value.backgroundColor = Constants.redColor.withAlphaComponent(0.7)
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
    @objc private func createAccountButtonPressed(sender: UIButton!) {
        guard
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
        else {
            print("Missing data in Email/Password field.")
            return
        }

        FireBaseManager.shared.createAccount(email: email, password: password, viewController: self)
    }

    // MARK: Indicate succes or invalid format of password and email
    private func checkEmailAndPassword(responce: String) {
        if emailTextField.isEditing {
            let emailResponce = Validator.shared.validate(values: (ValidationType.email, responce))

            switch emailResponce {
            case .success:
                print("success")
                emailTextField.lineColor = .green
                emailTextField.selectedLineColor = .green
            case .failure(_, let message):
                emailTextField.lineColor = .red
                emailTextField.selectedLineColor = .red
                print(message.localized())
            }
        } else if passwordTextField.isEditing {
            let passwordResponce = Validator.shared.validate(values: (ValidationType.password, responce))

            switch passwordResponce {
            case .success:
                print("success")
                passwordTextField.lineColor = .green
                passwordTextField.selectedLineColor = .green
            case .failure(_, let message):
                passwordTextField.lineColor = .red
                passwordTextField.selectedLineColor = .red
                print(message.localized())
            }
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

        checkEmailAndPassword(responce: responce)

        return false
    }
}

// MARK: - Setup UI extension
extension CreateAccountViewController {
    func setupUI() {
        title = "Registration"
        view.backgroundColor = .systemBackground.withAlphaComponent(0.8)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(createAccountButton)

        emailTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.top.equalToSuperview().inset(50)
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
