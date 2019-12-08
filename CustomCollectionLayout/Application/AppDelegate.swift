//
//  AppDelegate.swift
//  CustomCollectionLayout
//
//  Created by Орлов Артём on 03/12/2019.
//  Copyright © 2019 Orlov Artem. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarViewController()
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
        return true
    }
}

