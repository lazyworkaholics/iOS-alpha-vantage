//
//  StringConstants.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 20/05/2021.
//

import Foundation

struct NETWORK {
    static let BASE_URL = "https://www.alphavantage.co/"
        
    static let EDIT_SYMBOL_PRE_RELATIVE_PATH = "query"
    
    static let PARAM_FUNCTION = "function"
    static let PARAM_INTRADAY = "TIME_SERIES_INTRADAY"
    static let PARAM_DAILYADJ = "TIME_SERIES_DAILY_ADJUSTED"
    static let PARAM_SEARCH = "SYMBOL_SEARCH"
    
    static let PARAM_SYMBOL = "symbol"
    static let PARAM_INTERVAL = "interval"
    static let PARAM_KEYWORDS = "keywords"
    
    static let API_KEY = "apikey"
}

struct ERROR {
    
    static let ERROR_MESSAGE_KEY = "Error Message"
    struct DOMAIN {
        
        static let NO_INTERNET = "aia_demo.local_error.no_internet"
        static let PARSING_ERROR = "aia_demo.local_error.parsing_failure"
        static let HTTPURLRESPONSE_ERROR = "aia_demo.local_error.httpurlresponse_error"
        static let STATUS_200_ERROR = "aia_demo.local_error.200_status_error"
    }
    
    struct CODE {
        
        static let NO_INTERNET = 1009
        static let PARSING_ERROR = 1010
        static let STATUS_200_ERROR = 1011
    }
    
    struct DESCRIPTION {
        
        static let NO_INTERNET = "Internet connection appears to be offline"
        static let PARSING_ERROR = "Cannot parse response of the httpclient"
    }
    
}

struct STRINGS {
    
    static let OK = "OK"
    static let YES = "Yes"
    static let NO = "No"
    static let SYMBOL = "symbol"
    static let OUTPUTSIZE = "outputsize"
    static let APIKEY = "apikey"
    static let APIKEY_DEFAULT_VALUE = "IGVRHGRSC9RIDNE3"
    
    static let INTERVAL = "interval"
    static let ONE_MIN = "1min"
    static let FIVE_MINS = "5min"
    static let FIFTEEN_MINS = "15min"
    static let THIRTY_MINS = "30min"
    static let SIXTY_MINS = "60min"
    static let BEST_MATCHES = "bestMatches"
    
    static let FULL = "full"
    static let COMPACT = "compact"
    
    static let USER_DEFAULTS_INTERVAL = "interval_key"
    static let USER_DEFAULTS_OUTPUTSIZE = "outputsize_key"
    static let KEYCHAIN_APIKEY = "api_key"
    
    static let MAIN = "Main"
    static let ERROR = "Error"
    static let DASHBOARD = "Dashboard"
    static let INTRADAY = "Intra Day"
    static let DAILYADJ = "Daily Adjusted"
    
    static let SETTINGS = "settings"
    static let BACK = "back"
    static let DOWN = "down"
    static let DASHBOARD2 = "dashboard"
    
    struct VIEWCONTROLLERS {
        
        static let DASHBOARD = "DashboardViewController"
        static let INTRADAY = "IntradayViewController"
        static let DAILYADJ = "DailyAdjViewController"
        static let SETTINGS = "SettingsViewController"
        static let SEARCH = "SearchDisplayViewController"
    }
    
    struct COLORS {
        
        static let FONT_COLOR = "font"
        static let NAV_COLOR = "navigation"
    }
}
