//
//  AppDelegate.swift
//  LesaraTestTask
//
//  Created by Hrybeniuk Mykola on 10/7/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    var appCoordinator : AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let rootWindow = window {
            appCoordinator = AppCoordinator(rootWindow)
            appCoordinator?.userSessionManager = UserSessionManager()
            appCoordinator?.start()
        }
        
        return true
    }

}

