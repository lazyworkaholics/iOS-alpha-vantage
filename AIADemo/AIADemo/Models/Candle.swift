//
//  Candle.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import Foundation

struct Candle: Decodable {
    
    var open: Double!
    var high: Double!
    var low: Double!
    var close: Double!
    
    var volume: Int64!
    
    var adjustedClose: Double?
    var dividendAmount: Double?
    var splitCoefficient: Double?
    
    var timeStamp: Date?
    
    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        
        case volume = "5. volume",
             volume1 = "6. volume"
        
        case adjustedClose = "5. adjusted close"
        case dividendAmount = "7. dividend amount"
        case splitCoefficient = "8. split coefficient"
        
        case timeStamp
    }
    
    init(from decoder:Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy:CodingKeys.self)
            
            open = try Double(container.decode(String.self, forKey: .open))
            high = try Double(container.decode(String.self, forKey: .high))
            low = try Double(container.decode(String.self, forKey: .low))
            close = try Double(container.decode(String.self, forKey: .close))
            
            let codingKeys = [CodingKeys.volume, CodingKeys.volume1]
            
            for codingkey in codingKeys {
                if container.allKeys.contains(codingkey) {
                    volume = try Int64(container.decode(String.self, forKey: codingkey))
                    break
                }
            }
            
            if container.allKeys.contains(.adjustedClose) {
                adjustedClose = try Double(container.decode(String.self, forKey: .adjustedClose))
            }
            if container.allKeys.contains(.dividendAmount) {
                dividendAmount = try Double(container.decode(String.self, forKey: .dividendAmount))
            }
            if container.allKeys.contains(.splitCoefficient) {
                splitCoefficient = try Double(container.decode(String.self, forKey: .splitCoefficient))
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
