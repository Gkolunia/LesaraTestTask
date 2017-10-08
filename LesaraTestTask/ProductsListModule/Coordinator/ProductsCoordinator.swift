//
//  ProductsCoordinator.swift
//  LesaraTestTask
//
//  Created by Hrybeniuk Mykola on 10/7/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/**
 * @brief Protocol of service manager which can get list of products.
 */
protocol ProductsListServiceManager {
    func getProducts(_ pageNumber: Int, handler:@escaping CompletionHandler<ProductsModel>)
}

/**
 * @brief Coordinator of products module. Can be expanded in further for show details.
 */
class ProductsCoordinator: CoordinatorProtocol {
    
    /**
     * @brief Service manger for getting products list.
     */
    var productsServiceManager : ProductsListServiceManager
    weak var productsListController : ProductsListController?
    
    init(_ manager : ProductsListServiceManager) {
        productsServiceManager = manager
    }
    
    func start(from navigationController: UINavigationController) {
        let productsController = UIStoryboard.productsListController()
        
        // Configuration of products controller.
        productsController.loadViewIfNeeded()
        productsController.paginationController = PaginationController({ (pageNumber, handler) in
            self.productsServiceManager.getProducts(pageNumber, handler: handler)
        })
        productsController.dataSource = ProductsDataSource(productsController.collectionView)
        
        let endlessScrollController = EndlessScrollController(productsController.collectionView)
        productsController.endlessScrollController = endlessScrollController
        productsController.title = "Products List"
        
        navigationController.pushViewController(productsController, animated: true)
        
        productsListController = productsController
    }
    
}
