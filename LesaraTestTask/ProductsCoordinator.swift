//
//  ProductsCoordinator.swift
//  LesaraTestTask
//
//  Created by Hrybeniuk Mykola on 10/7/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

class ProductsCoordinator: CoordinatorProtocol {
    
    func start(from navigationController: UINavigationController) {
        navigationController.pushViewController(ViewController(), animated: true)
    }
    
}
