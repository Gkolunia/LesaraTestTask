//
//  ProductItemModel.swift
//  LesaraTestTask
//
//  Created by Hrybeniuk Mykola on 10/8/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import Foundation

struct ProductItem : Codable {
    let name : String
    let icon : String
    let price : String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case icon = "thumbnail_path"
        case price = "price"
    }
    
}
