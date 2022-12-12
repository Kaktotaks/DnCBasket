//
//  BaseViewController.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 05.12.2022.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setUPNavItems(needed: Bool = true) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "door.left.hand.open"), style: .plain, target: self, action: #selector(logOutButtonTapped))
    }

    @objc func logOutButtonTapped() {
        FireBaseManager.shared.signOut {
            self.dismiss(animated: true, completion: nil)
        }
    }

    func goToTapBar(vc: UIViewController, animated: Bool = true) {
        let tapBar = UINavigationController(rootViewController: TabBarController())
        tapBar.modalPresentationStyle = .fullScreen
        tapBar.modalTransitionStyle = .flipHorizontal
        vc.present(tapBar, animated: animated)
    }

    func goToCreateAccVC(vc: UIViewController) {
        let createAccVC = CreateAccountViewController()
        let navController = UINavigationController(rootViewController: createAccVC)
        if let sheet = navController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }

        vc.present(navController, animated: true)
    }
}
