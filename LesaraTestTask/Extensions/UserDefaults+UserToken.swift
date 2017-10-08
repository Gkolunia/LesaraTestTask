//
//  NSUserDefaults+UserToken.swift
//  LesaraTestTask
//
//  Created by Hrybeniuk Mykola on 10/8/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import Foundation

fileprivate struct UserDefaultsConstants {
    static let kUserToken = "kUserToken"
}

/**
 * @brief UserDefaults for saving user token. Just for convenience usage.
 */
extension UserDefaults {
    
    func lastUserToken() -> DeviceTokenModel? {
        
        guard let encodedData = UserDefaults.standard.value(forKey: UserDefaultsConstants.kUserToken) as? Data else {
            return nil
        }
        
        do {
            let userTokenModel = try JSONDecoder().decode(DeviceTokenModel.self, from: encodedData)
            return userTokenModel
        }
        catch {
            print(error)
        }
        
        return nil
    }
    
    func saveUserToken(_ credentials: DeviceTokenModel) {
        let encodedData = try? JSONEncoder().encode(credentials)
        UserDefaults.standard.setValue(encodedData, forKey: UserDefaultsConstants.kUserToken)
        UserDefaults.standard.synchronize()
    }
    
    func removeLastUserToken() {
        UserDefaults.standard.set(nil, forKey: UserDefaultsConstants.kUserToken)
        UserDefaults.standard.synchronize()
    }
    
}
