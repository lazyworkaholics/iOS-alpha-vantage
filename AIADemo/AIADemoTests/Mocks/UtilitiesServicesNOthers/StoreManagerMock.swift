//
//  StoreManagerMock.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 25/05/2021.
//

import Foundation
@testable import AIADemo

class StoreManagerMock: StorageManagerProtocol {
    
    var getInterval_mock:Interval?
    var is_getInterval_called:Bool?
    var is_setInterval_called:Bool?
    var getOutputSize_mock:String?
    var is_getOutputSize_called:Bool?
    var is_setOutputSize_called:Bool?
    var is_getAPIKey_called:Bool?
    var getAPIKey_mock:String?
    var is_setAPIKey_called:Bool?
    
    var mock_searches:[Search]?
    var is_getDashboardData_called:Bool?
    var is_saveToDashboardData_called:Bool?
    var is_deleteFromDashboardData_called:Bool?
    
    
    func getInterval() -> Interval {
        
        is_getInterval_called = true
        return getInterval_mock!
    }
    
    func setInterval(interval: Interval) {
        is_setInterval_called = true
    }
    
    func getOutputSize() -> String {
        
        is_getOutputSize_called = true
        return getOutputSize_mock!
    }
    
    func setOutputSize(value: OutputSize) {
        is_setOutputSize_called = true
    }
    
    func getAPIKey() -> String {
        is_getAPIKey_called = true
        return getAPIKey_mock!
    }
    
    func setAPIKey(key: String) {
        is_setAPIKey_called = true
    }
    
    func getDashboardData() -> [Search] {
        is_getDashboardData_called = true
        return mock_searches!
    }
    
    func saveToDashboardData(object: Search) -> [Search] {
        is_saveToDashboardData_called = true
        return mock_searches!
    }
    
    func deleteFromDashboardData(object: Search) -> [Search] {
        is_deleteFromDashboardData_called = true
        return mock_searches!
    }
}
