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

struct ApiUrls {
    static let annonymosToken = "/anonuser"
    static let trendProducts = "/trendproducts"
}

struct ServiceConstants {
    static let baseUrl = "https://app-testing.lesara.de/restapi/v5"
    static let applicationToken = "this_is_an_app_token"
    static let sourceBaseUrl = "https://cdn.lesara.io/"
}

protocol TokenMangerProtocol {
    var tokenModel : DeviceTokenModel? { get }
}

class ServiceManager {

    private let userSessionManager : TokenMangerProtocol
    
    static func makeRequest<T: Codable>(_ urlString: String, _ httpParams: [String : String]? = nil, _ requestType: RequsetType, _ httpBody: Data? = nil, handler:@escaping CompletionHandler<T>) {
        
        var fullUrl = ServiceConstants.baseUrl+urlString+"?app_token="+ServiceConstants.applicationToken
        
        if let params = httpParams, params.count > 0 {
            var paramsPart : String = ""
            for key in params.keys {
                if let value = params[key] {
                    paramsPart = paramsPart+"&"+key+"="+value
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

    init(_ defaultUserSessionManager: TokenMangerProtocol) {
        userSessionManager = defaultUserSessionManager
    }
    
    private func makeUrlWithTokenAndStore<T: Codable>(_ urlString: String, _ httpParams: [String : String]? = nil, _ requestType: RequsetType, _ httpBody: Data? = nil, handler:@escaping CompletionHandler<T>) {
        
        var tokenAndStoreParams = ["store_id" : String(userSessionManager.tokenModel!.storeId),
                                   "user_token" : userSessionManager.tokenModel!.userToken]
        
        if let params = httpParams {
            tokenAndStoreParams.merge(zip(params.keys, params.values)){ (current, _) in current }
        }
        
        ServiceManager.makeRequest(urlString, tokenAndStoreParams, requestType, httpBody, handler: handler)
        
    }
    
}

extension ServiceManager : ProductsListServiceManager {
    
    func getProducts(_ pageNumber: Int = 0, handler:@escaping CompletionHandler<ProductsModel>) {
        var pageParam : [String : String]?
        if pageNumber != 0 {
            pageParam = ["page_override" : String(pageNumber)]
        }
        makeUrlWithTokenAndStore(ApiUrls.trendProducts, pageParam, RequsetType.get, handler: handler)
    }
    
}
