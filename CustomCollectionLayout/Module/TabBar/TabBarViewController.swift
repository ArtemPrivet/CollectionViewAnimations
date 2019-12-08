//
//  TabBarViewController.swift
//  CustomCollectionLayout
//
//  Created by Орлов Артём on 03/12/2019.
//  Copyright © 2019 Orlov Artem. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = makeViewControllers().map { UINavigationController(rootViewController: $0) }
    }
}

private extension TabBarViewController {
    func makeViewControllers() -> [UIViewController] {
        let homeViewController = HomeViewController()
        let favoritesViewController = FavoritesViewController()
        let repository = AnimalsRepository()
        let animalsPresenter = AnimalsPresenter(repository: repository)
        let viewController = AnimalsViewController(presenter: animalsPresenter)
        animalsPresenter.view = viewController
        
        homeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured,
                                                     tag: 0)
        favoritesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites,
                                                          tag: 1)
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more,
                                                 tag: 2)
        return [homeViewController, favoritesViewController, viewController]
    }
}
