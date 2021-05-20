//
//  StringConstants.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 20/05/2021.
//

import Foundation

struct NETWORK {
    static let BASE_URL = "https://www.alphavantage.co/"
        
    static let EDIT_SYMBOL_PRE_RELATIVE_PATH = "tba/"
    static let EDIT_SYMBOL_POST_RELATIVE_PATH = ".json"
    
    static let HTTP_HEADER_CONTENT_TYPE_KEY = "Content-Type"
    static let HTTP_HEADER_CONTENT_TYPE_VALUE_APP_JSON = "application/json"
}

struct ERROR {
    
    struct DOMAIN {
        
        static let NO_INTERNET = "aia_demo.local_error.no_internet"
        static let PARSING_ERROR = "aia_demo.local_error.parsing_failure"
        static let HTTPURLRESPONSE_ERROR = "aia_demo.local_error.httpurlresponse_error"
    }
    
    struct CODE {
        
        static let NO_INTERNET = 1009
        static let PARSING_ERROR = 1010
    }
    
    struct DESCRIPTION {
        
        static let NO_INTERNET = "Internet connection appears to be offline"
        static let PARSING_ERROR = "Cannot parse response of the httpclient"
    }
    
}
