//
//  ProductsDataSource.swift
//  LesaraTestTask
//
//  Created by Hrybeniuk Mykola on 10/8/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

class ProductsDataSource: NSObject, ProductsDataSourceProtocol {
    
    private weak var collectionView : UICollectionView?
    private var items : [ProductItem] = [ProductItem]()
    
    init(_ defaultCollectionView : UICollectionView) {
        super.init()
        collectionView = defaultCollectionView
        collectionView?.dataSource = self
    }
    
    func addProducts(_ products: [ProductItem]) {
        let previosCount = items.count
        items.append(contentsOf: products)
        var arrayIndexPath = [IndexPath]()
        for row in previosCount...items.count-1 {
            arrayIndexPath.append(IndexPath(row: row, section: 0))
        }
        collectionView?.insertItems(at: arrayIndexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductItemCell.reuseId, for: indexPath) as? ProductItemCell {
            cell.setupCell(with: items[indexPath.row])
            return cell
            
        }
        return UICollectionViewCell()
    }

}
