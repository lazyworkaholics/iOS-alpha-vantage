//
//  Candle.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 21/05/2021.
//

import Foundation

enum SortingID {
    
    case open
    case high
    case low
    case close
    case date
}

struct Company: Decodable {
    
    var errorMessage: String?
    var metadata: MetaData?
    
    var candles:[Candle] = []
    
    enum CodingKeys: String, CodingKey {
        case errorMessage = "Error Message"
        case metadata = "Meta Data"
        
        case timeSeries = "Time Series (1min)",
             timeSeries1 = "Time Series (5min)",
             timeSeries2 = "Time Series (15min)",
             timeSeries3 = "Time Series (30min)",
             timeSeries4 = "Time Series (60min)",
             timeSeries5 = "Time Series (Daily)"
    }
    
    init(from decoder:Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy:CodingKeys.self)
            if container.allKeys.contains(.errorMessage) {
                errorMessage = try container.decode(String.self, forKey: .errorMessage)
            } else {
                metadata = try container.decode(MetaData.self, forKey: .metadata)
                
                let codingKeys = [CodingKeys.timeSeries, CodingKeys.timeSeries1, CodingKeys.timeSeries2, CodingKeys.timeSeries3, CodingKeys.timeSeries4, CodingKeys.timeSeries5]
                
                for codingkey in codingKeys {
                    if container.allKeys.contains(codingkey) {
                        let timeSeries:[String:Candle] = try container.decode([String: Candle].self, forKey: codingkey)
                        for element in timeSeries {
                            var candle = element.value
                            let timeString = element.key
                            candle.timeStamp = Utilities().getDate(timeString, timeZone: (metadata?.timezone!)!)
                            candles.append(candle)
                        }
                        break
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getCandles(_ sortby:SortingID) -> [Candle] {
        
        switch sortby {
        case .open:
            return candles.sorted(by:{ $0.open > $1.open })
        case .high:
            return candles.sorted(by:{ $0.high > $1.high })
        case .low:
            return candles.sorted(by:{ $0.low > $1.low })
        case .close:
            return candles.sorted(by:{ $0.close > $1.close })
        default:
            return candles.sorted(by:{ $0.timeStamp!.timeIntervalSince1970 > $1.timeStamp!.timeIntervalSince1970 })
        }
    }
}
