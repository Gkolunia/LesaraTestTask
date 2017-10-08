//
//  ViewController.swift
//  LesaraTestTask
//
//  Created by Hrybeniuk Mykola on 10/7/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/**
 * @brief Data source for collection view. Can add new items.
 */
protocol ProductsDataSourceProtocol : UICollectionViewDataSource {
    func addProducts(_ products: [ProductItem])
}

/**
 * @brief Controller for getting events when need to get new items.
 */
protocol EndlessScrollControllerProtocol : UIScrollViewDelegate {
    /**
     * @brief The call back is call every time when scrolling almost reachs end of content.
     */
    var needsLoadMoreCallBack : (() -> ())? { get set }
}

class ProductsListController: UIViewController {

    @IBOutlet weak var collectionView : UICollectionView!
    var dataSource : ProductsDataSourceProtocol!
    var paginationController : PaginationController<ProductsModel>!
    var endlessScrollController : EndlessScrollControllerProtocol!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadDataOrNextPage() // Load data
        
        endlessScrollController.needsLoadMoreCallBack = { // Register on event when need new data.
            self.loadDataOrNextPage() // Just get new page of data
        }
    }
    
    private func loadDataOrNextPage() {
        paginationController.nextPage { (success, products, error) in
            if let existProducts = products?.products, existProducts.count > 0  {
                self.dataSource.addProducts(existProducts) // If new data exist, append it to current data source.
            }
        }
    }

}

