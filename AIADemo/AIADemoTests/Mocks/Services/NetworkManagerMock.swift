//
//  NetworkManagerMock.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import Foundation
@testable import AIADemo

class NetworkManagerMock: NetworkManagerProtocol {

    var data: Data?
    var error: NSError?
    var isSuccess: Bool?
    
    static var sharedInstance:NetworkManagerProtocol = NetworkManagerMock()
    
    func httpRequest(_ urlPath:String,
                     params: [String: String]?,
                     method: HTTPRequestType,
                     headers: [String: String]?,
                     body: Data?,
                     onSuccess successBlock:@escaping (Data)->Void,
                     onFailure failureBlock:@escaping (NSError)->Void)
    {
        
        if isSuccess!
        {
            successBlock(data!)
        }
        else
        {
            failureBlock(error!)
        }
    }
}
