//
//  Search.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 23/05/2021.
//

import Foundation

struct Search: Decodable {
    
    var symbol: String!
    var name: String!
    
    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
    }
}
