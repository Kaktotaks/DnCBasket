//
//  CreateAccountViewController.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 06.12.2022.
//

import UIKit
import SkyFloatingLabelTextField

class CreateAccountViewController: UIViewController {
    // MARK: - Constants & Variables
    private lazy var emailTextField: SkyFloatingLabelTextField = {
        let value = SkyFloatingLabelTextField()
        value.placeholder = Constants.emailPlaceholderText
        value.title = Constants.emailTitleText
        value.selectedTitleColor = .systemGray
        value.font = UIFont.systemFont(ofSize: 20)
        value.autocapitalizationType = .none
        value.leftViewMode = .always
        return value
    }()

    private lazy var passwordTextField: SkyFloatingLabelTextField = {
        let value = SkyFloatingLabelTextField()
        value.placeholder = Constants.passPlaceholderText
        value.title = Constants.passPlaceholderText
        value.selectedTitleColor = .systemGray
        value.font = UIFont.systemFont(ofSize: 20)
        value.autocapitalizationType = .none
        value.leftViewMode = .always
        value.isSecureTextEntry = true
        return value
    }()

    private lazy var createAccountButton: UIButton = {
        let value: UIButton = .init()
        value.backgroundColor = Constants.redColor.withAlphaComponent(0.7)
        value.addTarget(self, action: #selector(createAccountButtonPressed), for: .touchUpInside)
        value.setTitleColor(.white, for: .normal)
        value.setTitle(Constants.createAccount.localized(), for: .normal)
        value.layer.cornerRadius = 10
        value.layer.borderWidth = 1
        value.layer.borderColor = UIColor.systemOrange.cgColor
        return value
    }()

    private lazy var showHidePasswordButton: UIButton = {
        let value: UIButton = .init()
        value.backgroundColor = .systemGray3.withAlphaComponent(0.2)
        value.addTarget(self, action: #selector(showHidePasswordButtonPressed), for: .touchUpInside)
        value.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        value.layer.cornerRadius = 10
        value.tintColor = Constants.redColor.withAlphaComponent(0.7)
        return value
    }()

    private lazy var buttonTogled = true

    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        passwordTextField.delegate = self
        setupUI()
    }

    // MARK: - Methods
    @objc private func createAccountButtonPressed(sender: UIButton!) {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text
        else {
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
                    emailTextField.lineColor = .green
                    emailTextField.selectedLineColor = .green
                case .failure:
                    emailTextField.lineColor = .red
                    emailTextField.selectedLineColor = .red
            }
        } else if passwordTextField.isEditing {
            let passwordResponce = Validator.shared.validate(values: (ValidationType.password, responce))

            switch passwordResponce {
                case .success:
                    passwordTextField.lineColor = .green
                    passwordTextField.selectedLineColor = .green
                case .failure:
                    passwordTextField.lineColor = .red
                    passwordTextField.selectedLineColor = .red
            }
        }
    }

    @objc private func showHidePasswordButtonPressed(_ sender: Any) {
        if buttonTogled == false {
            buttonTogled = true
            showHidePasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            passwordTextField.isSecureTextEntry = true
        } else {
            buttonTogled = false
            showHidePasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
            passwordTextField.isSecureTextEntry = false
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

// MARK: - Setup UI
extension CreateAccountViewController {
    func setupUI() {
        title = Constants.registrationText.localized()
        view.backgroundColor = .systemBackground.withAlphaComponent(0.8)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(createAccountButton)
        view.addSubview(showHidePasswordButton)

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

        showHidePasswordButton.snp.makeConstraints {
            $0.centerY.equalTo(passwordTextField)
            $0.trailing.equalToSuperview().inset(40)
            $0.width.height.equalTo(30)
        }
    }
}
