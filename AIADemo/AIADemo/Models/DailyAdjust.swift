//
//  DailyAdjust.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 24/05/2021.
//

import Foundation

struct DailyAdjust {
    
    var c1: String?
    var c2: String?
    var c3: String?
    
    var candles:[Candle_Compare] = []
}

struct Candle_Compare {
    
    var date: String?
    
    var open_c1: String?
    var open_c2: String?
    var open_c3: String?
    
    var low_c1: String?
    var low_c2: String?
    var low_c3: String?
}
