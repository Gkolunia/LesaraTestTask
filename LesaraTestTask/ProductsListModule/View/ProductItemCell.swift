//
//  ProductItemCell.swift
//  LesaraTestTask
//
//  Created by Hrybeniuk Mykola on 10/8/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

class ProductItemCell: UICollectionViewCell {
 
    static let reuseId = "ProductItemCellId"
 
    @IBOutlet weak var productImageView: ImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    func setupCell(with item : ProductItem) {
        productName.text = item.name
        productPrice.text = String(format: "%.2f", item.price)
        productImageView.loadImageFromURL(url: item.iconUrl)
    }
    
    override func prepareForReuse() {
        productImageView.cancelLoading()
        productImageView.image = nil
        productName.text = nil
        productPrice.text = nil
    }
    
}
