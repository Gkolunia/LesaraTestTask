//
//  UIImageView+LoadingFromUrl.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/13/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/**
 * @brief ImageView provides downloading image from given URL.
 */
class ImageView : UIImageView {
    
    /**
     * @brief Current downloading. Can be canceled for example from table view cell. When cell is reused but previous loading is not finished.
     */
    private var urlTask : URLSessionDataTask?
    
    public func loadImageFromURL(url: URL) {
        
        urlTask = URLSession.shared.dataTask(with: url, completionHandler: {[weak self] (data, response, error) -> Void in
            
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                if let dataExist = data {
                    let image = UIImage(data: dataExist)
                    self?.image = image
                }
                
            })
            
        })
        
        urlTask?.resume()
        
    }
    
    public func cancelLoading() {
        if let task = urlTask {
            task.cancel()
            urlTask = nil
        }
    }

}
