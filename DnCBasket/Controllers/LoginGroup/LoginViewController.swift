//
//  LoginViewController.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 05.12.2022.
//

import UIKit
import SnapKit
import Lottie
import SkyFloatingLabelTextField

class LoginViewController: BaseViewController {
    // MARK: - Constants & Variables

    private let dncLabel: UILabel = {
        let value: UILabel = .init()
        value.text = Constants.dncLabel
        value.textAlignment = .center
        value.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        return value
    }()

    private lazy var emailTextField: SkyFloatingLabelTextField = {
        let value = SkyFloatingLabelTextField()
        value.placeholder = Constants.emailPlaceholderText
        value.title = "Email"
        value.selectedTitleColor = .systemGray
        value.selectedLineColor = .systemGray4
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
        value.selectedLineColor = .systemGray4
        value.isSecureTextEntry = true
        value.font = UIFont.systemFont(ofSize: 20)
        value.autocapitalizationType = .none
        value.leftViewMode = .always
        return value
    }()

    private let loginButton: UIButton = {
        let value: UIButton = .init()
        value.backgroundColor = Constants.redColor.withAlphaComponent(0.7)
        value.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        value.setTitleColor(.label, for: .normal)
        value.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        value.setTitle(Constants.loginButtonTitle, for: .normal)
        value.layer.cornerRadius = 10
        value.layer.borderWidth = 1
        value.layer.borderColor = UIColor.systemOrange.cgColor
        return value
    }()

    private lazy var createNewAccountButton: UIButton = {
        let value: UIButton = .init()
        value.backgroundColor = Constants.redColor.withAlphaComponent(0.7)
        value.addTarget(self, action: #selector(createNewAccountButtonPressed), for: .touchUpInside)
        value.setTitleColor(.label, for: .normal)
        value.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        value.setTitle(Constants.createButtonTitle, for: .normal)
        value.layer.cornerRadius = 10
        value.layer.borderWidth = 1
        value.layer.borderColor = UIColor.systemOrange.cgColor
        return value
    }()

    private lazy var enterAsGuestButton: UIButton = {
        let value: UIButton = .init()
        value.backgroundColor = Constants.redColor.withAlphaComponent(0.2)
        value.addTarget(self, action: #selector(enterAsGuestButtonPressed), for: .touchUpInside)
        value.setTitleColor(.label, for: .normal)
        value.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        value.setTitle(Constants.enterAsGuestButtonTitle, for: .normal)
        value.layer.cornerRadius = 10
        return value
    }()

    private let basketBalAnimationView: LottieAnimationView = {
        let value: LottieAnimationView = .init(name: "spinBasketball")
        value.contentMode = .scaleAspectFit
        value.loopMode = .loop
        value.play()
        return value
    }()

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        userLogedIn()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        emailTextField.becomeFirstResponder()
    }

    // MARK: - Functions
    @objc func loginButtonPressed(sender: UIButton!) {
        guard
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
        else {
            return
        }

        FireBaseManager.shared.logInToAccount(email: email, password: password, viewController: self) {
            self.goToTapBar(vc: self)
        }
    }

    @objc func createNewAccountButtonPressed(sender: UIButton!) {
        self.goToCreateAccVC(vc: self)
    }

    @objc func enterAsGuestButtonPressed(sender: UIButton!) {
        self.goToTapBar(vc: self)
    // MARK: Enter as a guest
    }

    private func userLogedIn() {
        if FireBaseManager.shared.currentUser != nil {
            self.goToTapBar(vc: self, animated: false)
        }
    }
}

// MARK: - Constraints extension
extension LoginViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(dncLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(createNewAccountButton)
        view.addSubview(enterAsGuestButton)
        view.addSubview(basketBalAnimationView)

        dncLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.width.equalTo(300)
            $0.top.equalToSuperview().inset(80)
            $0.height.equalTo(100)
        }

        emailTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.top.equalTo(dncLabel).inset(100)
            $0.height.equalTo(40)
        }

        passwordTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.top.equalTo(emailTextField).inset(60)
            $0.height.equalTo(40)
        }

        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(160)
            $0.top.equalTo(passwordTextField).inset(60)
            $0.height.equalTo(40)
        }

        createNewAccountButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(160)
            $0.top.equalTo(loginButton).inset(50)
            $0.height.equalTo(40)
        }

        enterAsGuestButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(160)
            $0.top.equalTo(createNewAccountButton).inset(50)
            $0.height.equalTo(40)
        }

        basketBalAnimationView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(100)
            $0.bottom.equalTo(dncLabel).inset(18)
        }
    }
}
