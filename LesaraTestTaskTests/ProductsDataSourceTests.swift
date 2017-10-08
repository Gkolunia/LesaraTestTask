//
//  ProductsDataSourceTest.swift
//  LesaraTestTaskTests
//
//  Created by Hrybeniuk Mykola on 10/8/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import XCTest
@testable import LesaraTestTask

class CollectionViewMock : UICollectionView {
    
    var registeredCellId : String?
    var insertedCount : Int = 0
    
    override func insertItems(at indexPaths: [IndexPath]) {
        insertedCount = indexPaths.count
    }
    
    override func register(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        registeredCellId = identifier
    }
    
}

class ProductsDataSourceTests: XCTestCase {
    
    var dataSource : ProductsDataSource!
    var collectionView : CollectionViewMock!
    
    override func setUp() {
        super.setUp()
        collectionView = CollectionViewMock(frame: CGRect(), collectionViewLayout: UICollectionViewLayout())
        dataSource = ProductsDataSource(collectionView)
    }
    
    override func tearDown() {
        dataSource = nil
        collectionView = nil
        super.tearDown()
    }
    
    func testInit() {
        XCTAssert(collectionView.registeredCellId == ProductItemCell.reuseId)
        XCTAssert(collectionView.dataSource === dataSource)
    }
    
    func testAddProducts() {
        let products = StubModelsGenerator.generateProductsStub()
        dataSource.addProducts(products)
        XCTAssert(products.count == collectionView.insertedCount)
        XCTAssert(collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: 0) == products.count)
        
        dataSource.addProducts(products)
        XCTAssert(products.count == collectionView.insertedCount)
        XCTAssert(collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: 0) == products.count*2)
        
    }

}
