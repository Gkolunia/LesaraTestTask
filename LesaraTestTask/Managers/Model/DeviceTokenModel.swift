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
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        locale = try container.decode(String.self, forKey: .locale)
        userToken = try container.decode(String.self, forKey: .userToken)
        do { // Sometimes store id is number. Is it bug on the server?
            storeId = try String(container.decode(Int.self, forKey: .storeId))
        }
        catch {
            storeId = try container.decode(String.self, forKey: .storeId)
        }
    }
    
}
