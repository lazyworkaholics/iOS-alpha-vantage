//
//  StorageManagerMock.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 23/05/2021.
//

import Foundation
@testable import AIADemo

class UserdefaultsMock: UserDefaults {
    
    var mockString:String?
    var mockObject:Any?
    
    var receivedSetValue:Any?
    
    override open func set(_ value: Any?, forKey defaultName: String) {
        receivedSetValue = value
    }
    
    override open func string(forKey defaultName: String) -> String? {
        
        return mockString
    }
    
    override open func object(forKey defaultName: String) -> Any? {
        
        return mockObject
    }
}
