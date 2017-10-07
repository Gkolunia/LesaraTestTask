//
//  ProductsModel.swift
//  LesaraTestTask
//
//  Created by Hrybeniuk Mykola on 10/7/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import Foundation

protocol PaginationModel {
    var count : Int { get }
    var pages : Int { get }
    var currentPage : Int { get }
}

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

struct ProductsModel : Codable, PaginationModel {
    let products : [ProductItem]
    var count : Int
    var pages : Int
    var currentPage : Int

    enum CodingKeys : String, CodingKey {
        case count = "number_products"
        case pages = "number_pages"
        case currentPage = "current_page"
        case products = "products"
    }
    
    enum RootCodingKey : String, CodingKey {
        case rootKey = "trend_products"
    }
    
    public init(from decoder: Decoder) throws {
        let containerRoot = try decoder.container(keyedBy: RootCodingKey.self)
        let container = try containerRoot.nestedContainer(keyedBy: CodingKeys.self, forKey: .rootKey)
        count = try container.decode(Int.self, forKey: .count)
        products = try container.decode([ProductItem].self, forKey: .products)
        pages = try container.decode(Int.self, forKey: .pages)
        currentPage = try Int(container.decode(String.self, forKey: .currentPage))!
    }
    
}
