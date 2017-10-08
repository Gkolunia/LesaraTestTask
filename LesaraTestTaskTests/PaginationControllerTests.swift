//
//  ProductsCoordinatorTests.swift
//  LesaraTestTaskTests
//
//  Created by Hrybeniuk Mykola on 10/8/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import XCTest
@testable import LesaraTestTask

class PaginationControllerTests : XCTestCase {

    func testPaginationFirstRun() {
        let stubModel = StubModelsGenerator.generateTrendsModelStub()
        var pageNumber = 1
        let pagination = PaginationController<ProductsModel> { (page, handler) in
            XCTAssert(page == pageNumber)
            handler(true, stubModel, nil)
            
        }
        pagination.nextPage { (success, model, error) in
            XCTAssert(success)
            XCTAssert(model != nil)
            XCTAssert(error == nil)
        }
        
        pageNumber = pageNumber+1
        pagination.nextPage { (success, model, error) in
            
        }
    }
    
}
