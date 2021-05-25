//
//  SettingsViewModelTests.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 25/05/2021.
//

import XCTest
@testable import AIADemo

class SettingsViewModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {

    }
    
    func test_settingsInit() {
        let viewModel = SettingsViewModel.init()
        XCTAssertNotNil(viewModel)
    }
    
    func test_routeToDashboard() {
        var viewmodel = SettingsViewModel.init()
        
        let routerMock = RouterMock.init()
        viewmodel.router = routerMock
        
        viewmodel.routeToDashboard()
        XCTAssertTrue(routerMock.is_backToDashboard_called,"Router's backToDashboard should be called")
    }
    
    func test_getOutputSizeSegmentIndex() {
        var viewmodel = SettingsViewModel.init()
        let mockStoreManager = StoreManagerMock.init()
        viewmodel.storageManager = mockStoreManager
        
        mockStoreManager.getOutputSize_mock = "compact"
        XCTAssertEqual(viewmodel.getOutputSizeSegmentIndex(), 0)
        
        mockStoreManager.getOutputSize_mock = "full"
        XCTAssertEqual(viewmodel.getOutputSizeSegmentIndex(), 1)
    }
    
    func test_setOutputSize() {
        var viewmodel = SettingsViewModel.init()
        let mockStoreManager = StoreManagerMock.init()
        viewmodel.storageManager = mockStoreManager
        viewmodel.setOutputSize(index: 0)
        XCTAssertTrue(mockStoreManager.is_setOutputSize_called, "setOutputSize should be invoked")
        mockStoreManager.is_setOutputSize_called = false
        viewmodel.setOutputSize(index: 1)
        XCTAssertTrue(mockStoreManager.is_setOutputSize_called, "setOutputSize should be invoked")
    }
    
    func test_getIntervalSegmentIndex() {
        var viewmodel = SettingsViewModel.init()
        let mockStoreManager = StoreManagerMock.init()
        viewmodel.storageManager = mockStoreManager
        
        mockStoreManager.getInterval_mock = Interval.ONE_MIN
        XCTAssertEqual(viewmodel.getIntervalSegmentIndex(), 0)
        XCTAssertTrue(mockStoreManager.is_getInterval_called)
        
        mockStoreManager.is_getInterval_called = false
        mockStoreManager.getInterval_mock = Interval.FIVE_MINS
        XCTAssertEqual(viewmodel.getIntervalSegmentIndex(), 1)
        XCTAssertTrue(mockStoreManager.is_getInterval_called)
        
        mockStoreManager.is_getInterval_called = false
        mockStoreManager.getInterval_mock = Interval.FIFTEEN_MINS
        XCTAssertEqual(viewmodel.getIntervalSegmentIndex(), 2)
        XCTAssertTrue(mockStoreManager.is_getInterval_called)
        
        mockStoreManager.is_getInterval_called = false
        mockStoreManager.getInterval_mock = Interval.THIRTY_MINS
        XCTAssertEqual(viewmodel.getIntervalSegmentIndex(), 3)
        XCTAssertTrue(mockStoreManager.is_getInterval_called)
        
        mockStoreManager.is_getInterval_called = false
        mockStoreManager.getInterval_mock = Interval.SIXTY_MINS
        XCTAssertEqual(viewmodel.getIntervalSegmentIndex(), 4)
        XCTAssertTrue(mockStoreManager.is_getInterval_called)
    }
    
    func test_setInterval() {
        var viewmodel = SettingsViewModel.init()
        let mockStoreManager = StoreManagerMock.init()
        viewmodel.storageManager = mockStoreManager
        
        viewmodel.setInterval(index: 0)
        XCTAssertTrue(mockStoreManager.is_setInterval_called, "setInterval should be invoked")
        
        mockStoreManager.is_setInterval_called = false
        viewmodel.setInterval(index: 1)
        XCTAssertTrue(mockStoreManager.is_setInterval_called, "setInterval should be invoked")
        
        mockStoreManager.is_setInterval_called = false
        viewmodel.setInterval(index: 2)
        XCTAssertTrue(mockStoreManager.is_setInterval_called, "setInterval should be invoked")
        
        mockStoreManager.is_setInterval_called = false
        viewmodel.setInterval(index: 3)
        XCTAssertTrue(mockStoreManager.is_setInterval_called, "setInterval should be invoked")
        
        mockStoreManager.is_setInterval_called = false
        viewmodel.setInterval(index: 4)
        XCTAssertTrue(mockStoreManager.is_setInterval_called, "setInterval should be invoked")
    }
    
    func test_getAPIKey() {
        var viewmodel = SettingsViewModel.init()
        let mockStoreManager = StoreManagerMock.init()
        viewmodel.storageManager = mockStoreManager
        
        mockStoreManager.getAPIKey_mock = "TestString"
        XCTAssertEqual(viewmodel.getapikeyText(), "TestString")
    }
    
    func test_setAPIKey() {
        var viewmodel = SettingsViewModel.init()
        let mockStoreManager = StoreManagerMock.init()
        viewmodel.storageManager = mockStoreManager
        
        viewmodel.setAPIKey(key: "testString")
        
        XCTAssertTrue(mockStoreManager.is_setAPIKey_called, "setAPIKey should be invoked")
    }
    
}
