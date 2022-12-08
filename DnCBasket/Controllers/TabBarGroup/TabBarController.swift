//
//  TabBarController.swift
//  DnCBasket
//
//  Created by Леонід Шевченко on 05.12.2022.
//
// swiftlint: disable all

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "door.left.hand.open"), style: .plain, target: self, action: #selector(logOutButtonTapped))
        view.backgroundColor = .systemBackground
           UITabBar.appearance().barTintColor = .systemBackground
           tabBar.tintColor = .label
           setupVCs()
    }

    // MARK: Made generic func for creation NavControllers
    fileprivate func createNavController(for rootViewController: UIViewController,
                                                    title: String,
                                                    image: UIImage) -> UIViewController {
          let navController = UINavigationController(rootViewController: rootViewController)
          navController.tabBarItem.title = title
          navController.tabBarItem.image = image
          navController.navigationBar.prefersLargeTitles = true
          rootViewController.navigationItem.title = title
          return navController
      }

    // MARK: Setup our NavControllers
    func setupVCs() {
          viewControllers = [
              createNavController(for: HomeViewController(), title: NSLocalizedString("Home", comment: ""), image: UIImage(systemName: "house")!),
              createNavController(for: TournamentsViewController(), title: NSLocalizedString("Tournaments", comment: ""), image: UIImage(systemName: "trophy")!),
              createNavController(for: TeamsViewController(), title: NSLocalizedString("Teams", comment: ""), image: UIImage(systemName: "figure.basketball")!),
              createNavController(for: AccountViewController(), title: NSLocalizedString("Account", comment: ""), image: UIImage(systemName: "person")!)
          ]
      }
    
    @objc func logOutButtonTapped() {
        FireBaseManager.shared.signOut {
            self.dismiss(animated: true, completion: nil)
        }
    }
}
