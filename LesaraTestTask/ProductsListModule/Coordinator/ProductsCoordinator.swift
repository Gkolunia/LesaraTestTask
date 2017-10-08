//
//  ProductsCoordinator.swift
//  LesaraTestTask
//
//  Created by Hrybeniuk Mykola on 10/7/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

protocol ProductsListServiceManager {
    func getProducts(_ pageNumber: Int, handler:@escaping CompletionHandler<ProductsModel>)
}

class ProductsCoordinator: CoordinatorProtocol {
    
    var productsServiceManager : ProductsListServiceManager
    
    init(_ manager : ProductsListServiceManager) {
        productsServiceManager = manager
    }
    
    func start(from navigationController: UINavigationController) {
        let productsController = UIStoryboard.productsListController()
        productsController.loadViewIfNeeded()
        let pagination = PaginationController({[unowned self] (pageNumber, handler) in
            self.productsServiceManager.getProducts(pageNumber, handler: handler)
        })
        productsController.paginationController = pagination
        productsController.dataSource = ProductsDataSource(productsController.collectionView)
        
        let endlessScrollController = EndlessScrollController(productsController.collectionView)
        productsController.endlessScrollController = endlessScrollController
        productsController.title = "Products List"
        navigationController.pushViewController(productsController, animated: true)
    }
    
}
