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

    private let router: RouterProtocol = Router()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = router.initialWindow(.login, type: .navigation)
        window?.makeKeyAndVisible()

        return true
    }
}
