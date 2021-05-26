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
}

struct Candle_Lite {
    
    var open:String!
    var high:String!
    var low:String!
    var close:String!
}
