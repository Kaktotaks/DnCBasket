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
          return navController
      }

    // MARK: Setup our NavControllers
    func setupVCs() {
          viewControllers = [
            createNavController(for: HomeViewController(), title: NSLocalizedString(Constants.homeTabBarTitle, comment: ""), image: UIImage(systemName: "house")!),
              createNavController(for: TournamentViewController(), title: NSLocalizedString(Constants.tournamentTabBarTitle, comment: ""), image: UIImage(systemName: "trophy")!),
              createNavController(for: TeamsViewController(), title: NSLocalizedString(Constants.teamsTabBarTitle, comment: ""), image: UIImage(systemName: "person.3")!),
              createNavController(for: AccountViewController(), title: NSLocalizedString(Constants.accountTabBarTitle, comment: ""), image: UIImage(systemName: "person")!)
          ]
      }
}
