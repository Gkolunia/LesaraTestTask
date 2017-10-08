//
//  ViewController.swift
//  LesaraTestTask
//
//  Created by Hrybeniuk Mykola on 10/7/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

class ProductsListController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var paginationController : PaginationController<ProductsModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Products List"
        paginationController.nextPage { (success, products, error) in
            
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//    }

}

