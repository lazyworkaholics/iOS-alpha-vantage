//
//  ServiceManager.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 21/05/2021.
//

import Foundation

struct ServiceManager: ServiceManagerProtocol   {
    
    var networkManager:NetworkManagerProtocol

    init() {
        self.networkManager = NetworkManager.init()
    }
    
    
    //MARK: - Internal functions
    internal func getData(_ companySymbol: String, isIntraDay: Bool,
                        onSuccess successBlock: @escaping (Company) -> Void,
                        onFailure failureBlock: @escaping (NSError) -> Void) {
        
        var params = [STRINGS.SYMBOL:companySymbol,
                      STRINGS.APIKEY:Utilities().getAPIKey(),
                      STRINGS.OUTPUTSIZE:Utilities().getOutputSize()]
        
        if isIntraDay {
            params[NETWORK.PARAM_FUNCTION] = NETWORK.PARAM_INTRADAY
            params[STRINGS.INTERVAL] = Utilities().getInterval()
        } else {
            params[NETWORK.PARAM_FUNCTION] = NETWORK.PARAM_DAILYADJ
        }
        
        _networkRequest(urlPath: NETWORK.EDIT_SYMBOL_PRE_RELATIVE_PATH,
                        params: params,
                        method: HTTPRequestType.GET,
                        headers: nil,
                        body: nil,
                        onSuccess: {
                            (company) in
                            successBlock(company)
                        },
                        onFailure: {
                            (error) in
                            failureBlock(error)
                        })
    }
    
    
    private func _networkRequest<T1:Decodable>(urlPath:String,
                                           params: [String: String]?,
                                           method: HTTPRequestType,
                                           headers: [String: String]?,
                                           body: Data?,
                                           onSuccess successBlock:@escaping (T1)->Void,
                                           onFailure failureBlock:@escaping (NSError)->Void) {
        networkManager.httpRequest(urlPath,
                                   params: params,
                                   method: method,
                                   headers: headers,
                                   body: body,
                                   onSuccess: { (data) in
                                    
                                    let decoder = JSONDecoder.init()
                                    do {
                                        let transformedData =  try decoder.decode(T1.self, from: data)
                                        successBlock(transformedData)
                                    } catch {
                                        failureBlock(error as NSError)
                                    }
        },
                                   onFailure: { (error) in
                                    
                                    failureBlock(error)
        })
    }
}
