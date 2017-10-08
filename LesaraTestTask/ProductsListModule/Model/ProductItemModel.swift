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
    let iconUrl : URL
    let price : Float
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case iconUrl = "thumbnail_path"
        case price = "price"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        price = try Float(container.decode(String.self, forKey: .price))!
        iconUrl = try URL(string: ServiceConstants.sourceBaseUrl+container.decode(String.self, forKey: .iconUrl))!
    }
    
}
