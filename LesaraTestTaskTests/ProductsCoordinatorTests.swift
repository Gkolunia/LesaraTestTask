//
//  ProductsCoordinatorTests.swift
//  LesaraTestTaskTests
//
//  Created by Hrybeniuk Mykola on 10/8/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import XCTest
@testable import LesaraTestTask

class ProductsCoordinatorTests : XCTestCase {
    
    override func setUp() {
        super.setUp()

    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func testStart() {
        
        let coordinator = ProductsCoordinator(ServiceManager(UserSessionManager()))
        let navigationController = UINavigationController()
        coordinator.start(from: navigationController)
        
        XCTAssert(coordinator.productsListController != nil)
        let productsController = coordinator.productsListController!
        
        XCTAssert(productsController.dataSource != nil)
        XCTAssert(productsController.endlessScrollController != nil)
        XCTAssert(productsController.paginationController != nil)
        
        XCTAssert(navigationController.viewControllers.contains(productsController))
    }
    
}
