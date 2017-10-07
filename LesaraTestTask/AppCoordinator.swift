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

class AppCoordinator {
    
    private let rootWindow : UIWindow
    private let rootNavigationController : UINavigationController = UINavigationController()
    private var childCoordinator : CoordinatorProtocol?
    
    init(_ defaultWindow: UIWindow) {
        rootWindow = defaultWindow
        rootWindow.rootViewController = rootNavigationController
        rootWindow.makeKeyAndVisible()
        rootNavigationController.view.backgroundColor = .white
    }
    
    func start() {
        
        ServiceManager().getDeviceToken()
        
        childCoordinator = ProductsCoordinator()
        childCoordinator?.start(from: rootNavigationController)
    }
    
}
