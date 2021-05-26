//
//  ServiceManagerProtocol.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 21/05/2021.
//

import Foundation

protocol ServiceManagerProtocol {
        
    func getData(_ company:String, isIntraday: Bool,
                         onSuccess successBlock:@escaping (Company)->Void,
                         onFailure failureBlock:@escaping (NSError)->Void)
    
    func search(_ searchString: String,
                        onSuccess successBlock: @escaping ([Search]) -> Void,
                        onFailure failureBlock: @escaping (NSError) -> Void)
    
    func getDailyAdjusts(_ companySymbols:[String],
                         onCompletion completionBlock: @escaping (DailyAdjust) -> Void)
    
}

protocol NetworkManagerProtocol {
    
    func httpRequest(_ urlPath:String,
                     params: [String: String]?,
                     method: HTTPRequestType,
                     headers: [String: String]?,
                     body: Data?,
                     onSuccess successBlock:@escaping (Data)->Void,
                     onFailure failureBlock:@escaping (NSError)->Void)
}
