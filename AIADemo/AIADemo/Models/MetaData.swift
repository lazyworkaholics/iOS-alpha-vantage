//
//  Company.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 21/05/2021.
//

import Foundation

struct MetaData: Decodable {
    
    //MARK: - Variables
    var information: String!
    var symbol: String!
    var refreshTime: Date!
    
    var interval:String?
    var outputSize: String!
    var timezone:String!

    //MARK:- Codable and Equatable confirmations
    enum CodingKeys: String, CodingKey {

        case information = "1. Information"
        case symbol = "2. Symbol"
        case refreshTime = "3. Last Refreshed"
        case interval = "4. Interval"
        
        case outputSize = "5. Output Size",
             outputSize1 = "4. Output Size"
        
        case timezone = "6. Time Zone",
             timezone1 = "5. Time Zone"
    }
    
    init(from decoder:Decoder) throws {
        
        do {
            let container = try decoder.container(keyedBy:CodingKeys.self)
            
            information = try container.decode(String.self, forKey: .information)
            symbol = try container.decode(String.self, forKey: .symbol)
            
            
            if container.allKeys.contains(.interval) {
                interval = try container.decode(String.self, forKey: .interval)
            }
            
            let outputSizeKeys = [CodingKeys.outputSize, CodingKeys.outputSize1]
            for codingkey in outputSizeKeys {
                if container.allKeys.contains(codingkey) {
                    outputSize = try container.decode(String.self, forKey: codingkey)
                    break
                }
            }
            
            let timezoneKeys = [CodingKeys.timezone, CodingKeys.timezone1]
            for codingkey in timezoneKeys {
                if container.allKeys.contains(codingkey) {
                    timezone = try container.decode(String.self, forKey: codingkey)
                    break
                }
            }
            
            refreshTime = try Utilities().getDate(container.decode(String.self, forKey: .refreshTime), timeZone: timezone)
        } catch {
            print(error.localizedDescription)
        }
    }
}
