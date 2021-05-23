//
//  StorageManagerTests.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 23/05/2021.
//

import XCTest
@testable import AIADemo

class StorageManagerTests: XCTestCase {
    
    var storageManager:StorageManager?

    override func setUpWithError() throws {
        
        storageManager = StorageManager.init()
    }

    override func tearDownWithError() throws {
        
        storageManager = nil
    }
    
    func test_getInterval() {
        
        let testInterval = "TestValue"
        let mockDefaults = UserdefaultsMock.init()
        mockDefaults.mockString = testInterval
        storageManager?.userDefaults = mockDefaults
        
        let returnValue = storageManager?.getInterval()
        XCTAssertEqual(testInterval, returnValue)
    }
    
    func test_getInterval_firstTime() {
        
        storageManager?.userDefaults = UserdefaultsMock.init()
        
        let returnValue = storageManager?.getInterval()
        XCTAssertEqual(STRINGS.FIFTEEN_MINS, returnValue)
    }
    
    func test_setInterval() {
        
        let testInterval = Interval.FIVE_MINS
        let mockDefaults = UserdefaultsMock.init()
        storageManager?.userDefaults = mockDefaults
        
        storageManager?.setInterval(interval: testInterval)
        XCTAssertEqual(mockDefaults.receivedSetValue as! String, testInterval.rawValue)
    }
    
    func test_getOutputSize() {
        
        let testInterval = "TestValue"
        let mockDefaults = UserdefaultsMock.init()
        mockDefaults.mockString = testInterval
        storageManager?.userDefaults = mockDefaults
        
        let returnValue = storageManager?.getOutputSize()
        XCTAssertEqual(testInterval, returnValue)
    }
    
    func test_getOutputSize_firstTime() {
        
        storageManager?.userDefaults = UserdefaultsMock.init()
        
        let returnValue = storageManager?.getOutputSize()
        XCTAssertEqual(STRINGS.COMPACT, returnValue)
    }
    
    func test_setOutputSize() {
        
        let testoutput = OutputSize.FULL
        let mockDefaults = UserdefaultsMock.init()
        storageManager?.userDefaults = mockDefaults
        
        storageManager?.setOutputSize(value: testoutput)
        XCTAssertEqual(mockDefaults.receivedSetValue as! String, testoutput.rawValue)
    }
    
    func test_getAPIKey() {
        
        let testInterval = "TestValue"
        let mockDefaults = UserdefaultsMock.init()
        mockDefaults.mockString = testInterval
        storageManager?.userDefaults = mockDefaults
        
        let returnValue = storageManager?.getAPIKey()
        XCTAssertEqual(testInterval, returnValue)
    }
    
    func test_getAPIKey_firstTime() {
        
        storageManager?.userDefaults = UserdefaultsMock.init()
        
        let returnValue = storageManager?.getAPIKey()
        XCTAssertEqual(STRINGS.APIKEY_DEFAULT_VALUE, returnValue)
    }
    
    func test_setAPIKey() {
        
        let testValue = "testAPIKEY"
        let mockDefaults = UserdefaultsMock.init()
        storageManager?.userDefaults = mockDefaults
        
        storageManager?.setAPIKey(key: testValue)
        XCTAssertEqual(mockDefaults.receivedSetValue as! String, testValue)
    }
    
    func test_getDashboardData() {
        var search1 = Search.init()
        search1.name = "testName"
        search1.symbol = "testSymbol"
        let testData = [search1]
        let mockDefaults = UserdefaultsMock.init()
        mockDefaults.mockObject = testData
        storageManager?.userDefaults = mockDefaults
        
        let returnValue = storageManager?.getDashboardData()
        XCTAssertEqual(testData.count, returnValue?.count)
        XCTAssertEqual(testData[0].name, returnValue![0].name)
    }
    
    func test_getDashboard_firstTime() {
        
        storageManager?.userDefaults = UserdefaultsMock.init()
        
        let returnValue = storageManager?.getDashboardData()
        XCTAssertEqual(returnValue?.count, 0)
    }
    
    func test_saveToDashboard() {
        
        var search1 = Search.init()
        search1.name = "testName"
        search1.symbol = "testSymbol"
        
        let mockDefaults = UserdefaultsMock.init()
        storageManager?.userDefaults = mockDefaults
        
        let testData = storageManager?.saveToDashboardData(object: search1)
        
        XCTAssertEqual(testData?.count, 1)
        XCTAssertEqual(testData?[0].name, search1.name)
    }
    
    func test_saveToDashboard2() {
        
        var testDataArray:[Search] = []
        for index in 1...50 {
            var search1 = Search.init()
            search1.name = "testName" + String(index)
            search1.symbol = "testSymbol" + String(index)
            testDataArray.append(search1)
        }
        
        let mockDefaults = UserdefaultsMock.init()
        mockDefaults.mockObject = testDataArray
        storageManager?.userDefaults = mockDefaults
        
        var search = Search.init()
        search.name = "testName"
        search.symbol = "testSymbol"
        let testData = storageManager?.saveToDashboardData(object: search)
        
        XCTAssertEqual(testData?.count, 50)
        XCTAssertEqual(testData?[0].name, search.name)
    }
    
    func test_deleteFromDashboard() {
        
        var testDataArray:[Search] = []
        for index in 1...10 {
            var search1 = Search.init()
            search1.name = "testName" + String(index)
            search1.symbol = "testSymbol" + String(index)
            testDataArray.append(search1)
        }
        
        var search = Search.init()
        search.name = "testName3"
        search.symbol = "testSymbol3"
        
        let mockDefaults = UserdefaultsMock.init()
        mockDefaults.mockObject = testDataArray
        storageManager?.userDefaults = mockDefaults
        
        let testData = storageManager?.deleteFromDashboardData(object: search)
        
        XCTAssertEqual(testData?.count, 9)
    }
    
    func test_deleteFromDashboard_nilCase() {
        
        var search = Search.init()
        search.name = "testName3"
        search.symbol = "testSymbol3"
        
        let mockDefaults = UserdefaultsMock.init()
        storageManager?.userDefaults = mockDefaults
        
        let testData = storageManager?.deleteFromDashboardData(object: search)
        
        XCTAssertEqual(testData?.count, 0)
    }
}
