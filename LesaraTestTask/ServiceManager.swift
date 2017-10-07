//
//  ServiceManager.swift
//  LesaraTestTask
//
//  Created by Hrybeniuk Mykola on 10/7/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import Foundation
import UIKit

enum RequsetType: String {
    case get = "GET"
    case post = "POST"
}

typealias ErrorMessage = (title: String, description: String?)

struct NetworkDomainErrors {
    static let noInternetConnection : ErrorMessage = ("No Internet Connection!", "Please connect to WiFi to see the latest data.")
    static let somethingGoesWrong : ErrorMessage = ("Something goes wrong.", nil)
}

typealias CompletionHandler<T> = (_ succes: Bool, _ object: T?,_ errorMessage: ErrorMessage?) -> ()


class ServiceManager {
    
    func makeRequest<T: Codable>(_ urlString: String, _ httpParams: [String : String]?, _ requestType: RequsetType, _ httpBody: Data? = nil, handler:@escaping CompletionHandler<T>) {
        
        var fullUrl = urlString
        
        if let params = httpParams, params.count > 0 {
            var paramsPart = "?"
            for key in params.keys {
                if let value = params[key] {
                    paramsPart = paramsPart+key+"="+value+"&"
                }
            }
            fullUrl = fullUrl+paramsPart
        }
        
        if let url = URL(string: fullUrl) {
            let session = URLSession.shared
            let request = NSMutableURLRequest(url: url)
            request.httpMethod = requestType.rawValue
            request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
            request.httpBody = httpBody
            let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
                
                guard let response: HTTPURLResponse = response as? HTTPURLResponse else {
                    if let error = error {
                        handler(false, nil, ("Network Error.", error.localizedDescription))
                    }
                    else {
                        handler(false, nil, NetworkDomainErrors.somethingGoesWrong)
                    }
                    return
                }
                
                switch response.statusCode {
                case 200...204:
                    if let dataResponse = data {
                        do {
                            let mappableObject = try JSONDecoder().decode(T.self, from: dataResponse)
                            DispatchQueue.main.async {
                                handler(true, mappableObject, nil)
                            }
                        } catch {
                            handler(false, nil, nil)
                        }
                    }
                    else {
                        DispatchQueue.main.async {
                            handler(true, nil, nil)
                        }
                    }
                default:
                    DispatchQueue.main.async {
                        if let error = error {
                            handler(false, nil, ("Server Error.", error.localizedDescription))
                        }
                        else {
                            handler(false, nil, ("Status Code "+String(response.statusCode), HTTPURLResponse.localizedString(forStatusCode: response.statusCode)))
                        }
                    }
                    
                }
                
            }
            task.resume()
        }
        
    }
    
    func getDeviceToken() {

        if let deviceVendorUUID = UIDevice.current.identifierForVendor, let locale = NSLocale.preferredLanguages.first {
            let uuid = deviceVendorUUID.uuidString
            
            do {
                let dataBody = try JSONSerialization.data(withJSONObject: ["device_locale" : locale, "app_instance_id" : uuid],
                                                          options: .prettyPrinted)
                makeRequest("https://app-testing.lesara.de/restapi/v5/anonuser",
                            ["app_token" : "this_is_an_app_token"],
                            RequsetType.post,
                            dataBody
                ) { (success, deviceModel : DeviceTokenModel?, error) in
                    
                    if let model = deviceModel, success {
                        print(model)
                    }
                    else {
                        
                    }
                    
                }
            }
            catch {
                
            }
        }

    }
    
}
