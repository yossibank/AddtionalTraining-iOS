//
//  AppDelegate.swift
//  AddtionalTraining-iOS
//
//  Created by KAMIYAMA YOSHIHITO on 2021/03/06.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let mainVC = MainNaviagtionController(
            rootViewController: R.storyboard.loginViewController.instantiateInitialViewController()!
        )
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()

        return true
    }
}
