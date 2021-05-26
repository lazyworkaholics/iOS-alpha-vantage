//
//  SettingsViewModelMock.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 26/05/2021.
//

import UIKit
@testable import AIADemo

class SettingsViewModelMock: SettingsViewModel {

    var is_getOutputSizeSegmentIndex_called = false
    var getOutputSizeSegmentIndex_mock:Int?
    var is_setOutputSize_callled = false
    var is_getIntervalSegmentIndex_called = false
    var getIntervalSegmentIndex_mock:Int?
    var is_setInterval_called = false
    var is_getapikeyText_calllled = false
    var getapikeyText_mock:String?
    var is_setAPIKey_called = false
    var is_routeToDashboard_called = false
    
    override func routeToDashboard() {
        
        is_routeToDashboard_called = true
    }
    
    override func getOutputSizeSegmentIndex() -> Int {
        
        is_getOutputSizeSegmentIndex_called = true
        return getOutputSizeSegmentIndex_mock!
    }
    
    override func setOutputSize(index:Int) {
        
        is_setOutputSize_callled = true
    }
    
    override func getIntervalSegmentIndex() -> Int{
        
        is_getIntervalSegmentIndex_called = true
        return getIntervalSegmentIndex_mock!
    }
    
    override func setInterval(index:Int) {
        is_setInterval_called  =  true
    }
    
    override func getapikeyText() -> String {
        is_getapikeyText_calllled = true
        return getapikeyText_mock!
    }
    
    override func setAPIKey(key:String) {
        is_setAPIKey_called = true
    }
}
