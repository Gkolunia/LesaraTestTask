//
//  AppCoordinator.swift
//  LesaraTestTask
//
//  Created by Hrybeniuk Mykola on 10/7/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/**
 * @brief Protocol defines common interface for all cordinators
 */
protocol CoordinatorProtocol {
    /**
     * @brief Method which starts navigation in current coordinator
     */
    func start(from navigationController: UINavigationController)
}

protocol UserSessionManagerProtocol {
    func getDeviceToken(handler: @escaping (_ sessionWithToken: UserSessionManager?) -> ())
}

/**
 * @brief The class provides root navigation for child coordinators.
 */
class AppCoordinator {
    
    private let rootWindow : UIWindow
    private let rootNavigationController : UINavigationController = UINavigationController()
    
    /**
     * @brief childCoordinator keeps reference on last coordinator
     */
    private var childCoordinator : CoordinatorProtocol?
    
    var serviceManager : ServiceManager!
    
    /**
     * @brief keeps reference on last user session
     */
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
