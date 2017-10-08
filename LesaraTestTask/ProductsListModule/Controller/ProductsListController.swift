//
//  ViewController.swift
//  LesaraTestTask
//
//  Created by Hrybeniuk Mykola on 10/7/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

protocol ProductsDataSourceProtocol : UICollectionViewDataSource {
    func addProducts(_ products: [ProductItem])
}

protocol EndlessScrollControllerProtocol : UIScrollViewDelegate {
    var needsLoadMoreCallBack : (() -> ())? { get set }
}

class ProductsListController: UIViewController {

    @IBOutlet weak var collectionView : UICollectionView!
    var dataSource : ProductsDataSourceProtocol!
    var paginationController : PaginationController<ProductsModel>!
    var endlessScrollController : EndlessScrollControllerProtocol!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadDataOrNextPage()
        
        endlessScrollController.needsLoadMoreCallBack = {
            self.loadDataOrNextPage()
        }
    }
    
    private func loadDataOrNextPage() {
        paginationController.nextPage { (success, products, error) in
            if let existProducts = products?.products, existProducts.count > 0  {
                self.dataSource.addProducts(existProducts)
            }
        }
    }

}

