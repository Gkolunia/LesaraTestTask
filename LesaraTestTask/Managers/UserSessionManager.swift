//
//  UserSessionManager.swift
//  LesaraTestTask
//
//  Created by Hrybeniuk Mykola on 10/7/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

class UserSessionManager :  UserSessionManagerProtocol, TokenMangerProtocol {
    
    var tokenModel: DeviceTokenModel?

    func getDeviceToken(handler: @escaping (_ sessionWithToken: UserSessionManager?) -> ()) {
        
        if let lastToken = UserDefaults().lastUserToken() {
            self.tokenModel = lastToken
            handler(self)
            return
        }
        
        if let deviceVendorUUID = UIDevice.current.identifierForVendor, let locale = NSLocale.preferredLanguages.first {
            let uuid = deviceVendorUUID.uuidString
            
            do {
                let dataBody = try JSONSerialization.data(withJSONObject: ["device_locale" : locale, "app_instance_id" : uuid],
                                                          options: .prettyPrinted)
                
                ServiceManager.makeRequest(ApiUrls.annonymosToken, nil, RequsetType.post, dataBody, handler: { (success, tokenModel : DeviceTokenModel?, error) in
                    if let existToken = tokenModel {
                        UserDefaults().saveUserToken(existToken)
                        self.tokenModel = existToken
                        handler(self)
                    }
                    if let errorExist = error {
                        print(errorExist)
                    }
                    handler(nil)
                })
            }
            catch {
                print(error)
                handler(nil)
            }
        }
        else {
            handler(nil)
        }
    }
    
    
}