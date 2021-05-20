//
//  NetworkManagerProtocol.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 20/05/2021.
//

import Foundation

protocol NetworkManagerProtocol {
    
    func httpRequest(_ urlPath:String,
                     params: [String: String]?,
                     method: HTTPRequestType,
                     headers: [String: String]?,
                     body: Data?,
                     onSuccess successBlock:@escaping (Data)->Void,
                     onFailure failureBlock:@escaping (NSError)->Void)
}
