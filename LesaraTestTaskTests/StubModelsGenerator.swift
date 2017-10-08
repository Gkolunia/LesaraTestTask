//
//  StubModelsGenerator.swift
//  LesaraTestTaskTests
//
//  Created by Hrybeniuk Mykola on 10/8/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import XCTest
@testable import LesaraTestTask

class StubModelsGenerator {
    
    static func generateProductsStub() -> [ProductItem] {
        
        let item1 = ["price" : "16.9900",
                     "name" : "Kurzes Tunika-Kleid mit Ärmelrüschen",
                     "thumbnail_path" : "catalog/product/cache/1/image/400x/9df78eab33525d08d6e5fb8d27136e95/l/e/lesa3_411ms-01-2.jpg"]
        
        let item2 = ["price" : "16.9900",
                     "name" : "Kurzes Tunika-Kleid mit Ärmelrüschen",
                     "thumbnail_path" : "catalog/product/cache/1/image/400x/9df78eab33525d08d6e5fb8d27136e95/l/e/lesa3_411ms-01-2.jpg"]
        
        let item3 = ["price" : "16.9900",
                     "name" : "Kurzes Tunika-Kleid mit Ärmelrüschen",
                     "thumbnail_path" : "catalog/product/cache/1/image/400x/9df78eab33525d08d6e5fb8d27136e95/l/e/lesa3_411ms-01-2.jpg"]
        
        let data1 = try! JSONSerialization.data(withJSONObject: item1, options: .prettyPrinted)
        let data2 = try! JSONSerialization.data(withJSONObject: item2, options: .prettyPrinted)
        let data3 = try! JSONSerialization.data(withJSONObject: item3, options: .prettyPrinted)
        
        let stub1 = try! JSONDecoder().decode(ProductItem.self, from: data1)
        let stub2 = try! JSONDecoder().decode(ProductItem.self, from: data2)
        let stub3 = try! JSONDecoder().decode(ProductItem.self, from: data3)
        
        return [stub1, stub2, stub3]
        
    }
    
    static func generateTrendsModelStub() -> ProductsModel {
        
        let item1 = ["price" : "16.9900",
                     "name" : "Kurzes Tunika-Kleid mit Ärmelrüschen",
                     "thumbnail_path" : "catalog/product/cache/1/image/400x/9df78eab33525d08d6e5fb8d27136e95/l/e/lesa3_411ms-01-2.jpg"]
        
        let rootModel = ["trend_products" : [ "products" : [item1],
                                              "number_products" : 17000,
                                              "number_pages" : 365,
                                              "current_page" : "1"]] as [String : Any]
        
        let data = try! JSONSerialization.data(withJSONObject: rootModel, options: .prettyPrinted)
        let stub = try! JSONDecoder().decode(ProductsModel.self, from: data)
        
        return stub
    }
}
