//
//  StoryBoard.swift
//  RecipesTestTask
//
//  Created by Hrybeniuk Mykola on 8/12/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import UIKit

struct StoryBoard {
    static let kProductsListControllerId = "ProductsListControllerID"
}

/**
 * @brief Default controllers of application in main story board. Just for convenience usage.
 */
extension UIStoryboard {
    
    class func main() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    class func productsListController() -> ProductsListController {
        return main().instantiateViewController(withIdentifier: StoryBoard.kProductsListControllerId) as! ProductsListController
    }
    
}
