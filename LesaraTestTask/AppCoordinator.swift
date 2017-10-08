//
//  AppCoordinator.swift
//  LesaraTestTask
//
//  Created by Hrybeniuk Mykola on 10/7/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol {
    func start(from navigationController: UINavigationController)
}

protocol UserSessionManagerProtocol {
    func getDeviceToken(handler: @escaping (_ sessionWithToken: UserSessionManager?) -> ())
}

class AppCoordinator {
    
    private let rootWindow : UIWindow
    private let rootNavigationController : UINavigationController = UINavigationController()
    private var childCoordinator : CoordinatorProtocol?
    
    var serviceManager : ServiceManager!
    var userSessionManager : UserSessionManagerProtocol!
    
    init(_ defaultWindow: UIWindow) {
        rootWindow = defaultWindow
        rootWindow.rootViewController = rootNavigationController
        rootWindow.makeKeyAndVisible()
        rootNavigationController.view.backgroundColor = .white
    }
    
    func start() {
        rootWindow.startLoading()
        userSessionManager.getDeviceToken {[unowned self] (userSession) in
            if let currentUserSession = userSession {
                self.serviceManager = ServiceManager(currentUserSession)
                self.showProductsList()
            }
            self.rootWindow.stopLaading()
        }
    }
    
    private func showProductsList() {
        self.childCoordinator = ProductsCoordinator(self.serviceManager)
        self.childCoordinator?.start(from: self.rootNavigationController)
    }
    
}
