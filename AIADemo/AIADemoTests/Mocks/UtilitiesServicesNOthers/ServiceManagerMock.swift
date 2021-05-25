//
//  ServiceManagerMock.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 25/05/2021.
//

import XCTest
@testable import AIADemo

struct ServiceManagerMock:ServiceManagerProtocol {
    
    var isServiceCallSuccess:Bool?
    var mock_company:Company?
    var mock_searches:[Search]?
    var mock_error:NSError?
    
    func getData(_ company: String, isIntraday: Bool, onSuccess successBlock: @escaping (Company) -> Void, onFailure failureBlock: @escaping (NSError) -> Void) {
        
        if isServiceCallSuccess! {
            successBlock(mock_company!)
        } else {
            failureBlock(mock_error!)
        }
    }
    
    func search(_ searchString: String, onSuccess successBlock: @escaping ([Search]) -> Void, onFailure failureBlock: @escaping (NSError) -> Void) {
        
        if isServiceCallSuccess! {
            successBlock(mock_searches!)
        } else {
            failureBlock(mock_error!)
        }
    }
    
    
    
}
