//
//  DailyAdjust.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 24/05/2021.
//

import Foundation

enum CompareBy {
    case open
    case high
    case low
    case close
}

struct DailyAdjust {
    
    var symbols:[String] = []
    var companies:[String:Company] = [:]
    var errors:[String:Error] = [:]
    
    var timeZone: String?
    var uniqueDates:[String] = []
    var parsedData:[String:[String:Candle_Lite]] = [:]
    
    mutating func parseData() {
        
        var dates:[String] = []
        var filtered:[String:[String:Candle_Lite]] = [:]
        for companyKeyValue in companies {
            
            if timeZone == nil {
                timeZone = (companyKeyValue.value.metadata?.timezone)
            }
            
            var lite_candles:[String:Candle_Lite] = [:]
            for candle in companyKeyValue.value.candles {
                let dateString = candle.getTimeStamp(timeZone: (companyKeyValue.value.metadata?.timezone!)!, isIntraday: false)
                dates.append(dateString)
                lite_candles[dateString] = Candle_Lite.init(open: String(candle.open), high: String(candle.high), low: String(candle.low), close: String(candle.close))
            }
            filtered[companyKeyValue.key] = lite_candles
        }
        
        uniqueDates = Array(Set(dates))
        uniqueDates = uniqueDates.sorted(by:{ $0 > $1 })
        parsedData = filtered
    }
}

struct Candle_Lite {
    
    var open:String!
    var high:String!
    var low:String!
    var close:String!
}
