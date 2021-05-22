//
//  NetworkManager.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 20/05/2021.
//

import Foundation
import SystemConfiguration

enum HTTPRequestType:String {
    case GET
    case POST
    case PUT
    case DELETE
}

struct NetworkManager: NetworkManagerProtocol {
    
    var urlSession : URLSession
    var isConnectedToNetwork:Bool
    
    init() {
        self.urlSession = URLSession.init(configuration: URLSessionConfiguration.default)
        self.isConnectedToNetwork = NetworkManager._updateNetworkConnection()
    }
    
    // http request function that handles the core networking with backend server
    func httpRequest(_ urlPath: String,
                     params: [String : String]?,
                     method: HTTPRequestType,
                     headers: [String : String]?,
                     body: Data?,
                     onSuccess successBlock: @escaping (Data) -> Void,
                     onFailure failureBlock: @escaping (NSError) -> Void) {
        
        // check if the device has internet connectivity, either through wifi or cellular
        if isConnectedToNetwork
        {
            guard let urlRequest = _requestConstructor(urlPath, params: params, method: method, headers: headers, body: body) else {
                return
            }
            
            _sessionDataTask(urlRequest, onSuccess: successBlock, onFailure: failureBlock)
        }
        else {
            // Network Error
            let errorObject = self._errorConstructor(ERROR.DOMAIN.NO_INTERNET, code: ERROR.CODE.NO_INTERNET, description: ERROR.DESCRIPTION.NO_INTERNET)
            failureBlock(errorObject)
        }
        
    }
    
    // MARK: -
    // core function to handle urlSession's dataTask
    // calls and validates the network response
    // with appropriate success and failure blocks
    private func _sessionDataTask(_ urlRequest:URLRequest,
                     onSuccess successBlock:@escaping (Data)->Void,
                     onFailure failureBlock:@escaping (NSError)->Void) {
        
        // urlsession's dataTask function call to fetch response from backent
        let dataTask = urlSession.dataTask(with: urlRequest) {
            (responseData, urlResponse, error) in
            
            if error == nil
            {
                if let urlResponse = urlResponse as? HTTPURLResponse
                {
                    //The API call was successful, go ahead and parse the data
                    if urlResponse.statusCode >= 200 && urlResponse.statusCode <= 206
                    {
                        if let responseData = responseData
                        {
                            successBlock(responseData)
                        }
                        else
                        {
                            //Oops we should never get here in the first place. Abort!
                            let errorObject = self._errorConstructor(ERROR.DOMAIN.PARSING_ERROR, code: ERROR.CODE.PARSING_ERROR, description: ERROR.DESCRIPTION.PARSING_ERROR)
                            failureBlock(errorObject)
                        }
                    }
                    else
                    {
                        let errorObject = self._errorConstructor(ERROR.DOMAIN.HTTPURLRESPONSE_ERROR, code: urlResponse.statusCode, description: HTTPURLResponse.localizedString(forStatusCode: urlResponse.statusCode))
                        failureBlock(errorObject)
                    }
                }
                else
                {
                    //Oops we should never get here in the first place. Abort!
                    let errorObject = self._errorConstructor(ERROR.DOMAIN.PARSING_ERROR, code: ERROR.CODE.PARSING_ERROR, description: ERROR.DESCRIPTION.PARSING_ERROR)
                    failureBlock(errorObject)
                }
            }
            else
            {
                failureBlock(error! as NSError)
            }
        }
        dataTask.resume()
    }
    
    // helper function to construct a urlRequest from given path, parameters, body etc
    private func _requestConstructor(_ urlPath:String,
                                     params: [String: String]?,
                                     method: HTTPRequestType,
                                     headers: [String: String]?,
                                     body: Data?) -> URLRequest? {
        
        guard var url = URL.init(string: NETWORK.BASE_URL) else {
            return nil
        }
        
        var relativePath = urlPath
        if params != nil
        {
            relativePath = relativePath + "?"
            var isFirstIteration:Bool = true
            for (key, value) in params! {
                if !isFirstIteration {
                    relativePath = relativePath + "&"
                }
                relativePath = relativePath + key + "=" + value
                isFirstIteration = false
            }
        }
        
        url = URL.init(string: url.appendingPathComponent(relativePath) .absoluteString.removingPercentEncoding!)!
        
        var urlRequest = URLRequest.init(url:url,
                                         cachePolicy: .useProtocolCachePolicy,
                                         timeoutInterval:60.0)
        urlRequest.httpMethod = method.rawValue
        
        if body != nil
        {
            urlRequest.httpBody = body
        }
        
        for (key, value) in headers ?? [:] {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
    
    // helper function to construct an error object from domain code and description
    private func _errorConstructor(_ domain:String, code:Int, description:String) -> NSError {
        
        let error = NSError.init(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey: description])
        return error
    }
    
    // helper function to check the presence of network to the device
    private static func _updateNetworkConnection() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
            
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection)
    }
}
