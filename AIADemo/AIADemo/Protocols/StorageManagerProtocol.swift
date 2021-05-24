//
//  StorageManagerProtocol.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 23/05/2021.
//

import Foundation

protocol StorageManagerProtocol {
    
    func getInterval() -> Interval
    func setInterval(interval:Interval)
    
    func getOutputSize() -> String
    func setOutputSize(value:OutputSize)
    
    func getDashboardData() -> [Search]
    func saveToDashboardData( object:Search) -> [Search]
    func deleteFromDashboardData( object:Search) -> [Search]
}

protocol UserDefaultsProtocol: UserDefaults {
    
    
}
