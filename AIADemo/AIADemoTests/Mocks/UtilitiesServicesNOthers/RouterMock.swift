//
//  RouterMock.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 25/05/2021.
//

import Foundation
import UIKit
@testable import AIADemo

class RouterMock:RouterProtocol {
    
    var is_appLaunch_called = false
    var is_navigateToIntraday_called = false
    var is_navigateToDailyAdj_called = false
    var is_navigateToSettings_called = false
    var is_backToDashboard_called = false
    var is_displaySearchView_called = false
    var is_hideSearchView_called = false
    
    var navigateToIntraday_search_received:Search?
    
    func appLaunch(_ window: UIWindow) {
        is_appLaunch_called = true
    }
    
    func navigateToIntraday(with search: Search) {
        is_navigateToIntraday_called = true
        navigateToIntraday_search_received = search
    }
    
    func navigateToDailyAdj(with searches: [Search]) {
        is_navigateToDailyAdj_called = true
    }
    
    func navigateToSettings() {
        is_navigateToSettings_called = true
    }
    
    func backToDashboard() {
        is_backToDashboard_called = true
    }
    
    func displaySearchView() {
        is_displaySearchView_called = true
    }
    
    func hideSearchView() {
        is_hideSearchView_called = true
    }
    
    
    
}
