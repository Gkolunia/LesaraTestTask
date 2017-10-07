//
//  DeviceTokenModel.swift
//  LesaraTestTask
//
//  Created by Hrybeniuk Mykola on 10/7/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import Foundation

struct DeviceTokenModel : Codable {
    
    var locale : String
    var userToken : String
    var storeId : String
    
    enum CodingKeys: String, CodingKey {
        case locale = "locale"
        case userToken = "user_token"
        case storeId = "store_id"
    }
    
}
