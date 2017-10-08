//
//  LesaraTestTaskTests.swift
//  LesaraTestTaskTests
//
//  Created by Hrybeniuk Mykola on 10/7/17.
//  Copyright © 2017 Hrybenuik Mykola. All rights reserved.
//

import XCTest
@testable import LesaraTestTask

class AppCoordinatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testInitWithWindow() {
        let window = UIWindow()
        let _ = AppCoordinator(window)
        XCTAssert(window.isKeyWindow)
        XCTAssert(window.rootViewController != nil)
    }
    
    func testStartAppCoordinatorSuccess() {
        
        class UserSessionManagerMock : UserSessionManagerProtocol {
            func getDeviceToken(handler: @escaping (UserSessionManager?) -> ()) {
                handler(UserSessionManager())
            }
        }
        
        let window = UIWindow()
        let coordinator = AppCoordinator(window)
        coordinator.userSessionManager = UserSessionManagerMock()
        coordinator.start()
        
        XCTAssert(coordinator.serviceManager != nil)
        XCTAssert(coordinator.userSessionManager != nil)
        
    }
    
    func testStartAppCoordinatorFailure() {
        
        class UserSessionManagerMock : UserSessionManagerProtocol {
            func getDeviceToken(handler: @escaping (UserSessionManager?) -> ()) {
                handler(nil)
            }
        }
        
        let window = UIWindow()
        let coordinator = AppCoordinator(window)
        coordinator.userSessionManager = UserSessionManagerMock()
        coordinator.start()
        
        XCTAssert(coordinator.serviceManager == nil)
        XCTAssert(coordinator.userSessionManager != nil)
        
    }
    
}
