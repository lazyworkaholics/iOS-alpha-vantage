//
//  DashboardViewModelMock.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 25/05/2021.
//

import Foundation
import UIKit
@testable import AIADemo

class DashboardViewModelMock: DashboardViewModel {
    
    var is_routeTosettingsView_called = false
    var is_routeToDailyView_called = false
    var is_segmentValueChange_called = false
    var is_searchforCompanies_called = false
    
    var itemsCount_stub:Int?
    var getDashboardCompanyName_stub:String?
    var is_getDashboardCompanyName_called = false
    
    var getDashboardCompanySymbol_stub:String?
    var is_getDashboardCompanySymbol_called = false
    
    var isDailyAdjustChecked_stub:Bool?
    var is_DailyAdjustChecked_called = false
    
    override func routeTosettingsView() {
        is_routeTosettingsView_called = true
    }
    
    override func routeToDailyView() {
        is_routeToDailyView_called = true
    }
    
    override func segmentValueChange(index: Int) {
        is_segmentValueChange_called = true
    }
    
    override func searchforCompanies(keyword: String) {
        is_searchforCompanies_called = true
    }
    
    override func getDashboardCompaniesCount() -> Int {
        return itemsCount_stub!
    }
    
    override func getDashboardCompanyName(for index:Int) -> String {
        is_getDashboardCompanyName_called = true
        return getDashboardCompanyName_stub!
    }
    
    override func getDashboardCompanySymbol(for index:Int) -> String {
        is_getDashboardCompanySymbol_called = true
        return getDashboardCompanySymbol_stub!
    }
    
    override func isDailyAdjustChecked(index:Int) ->  Bool {
        is_DailyAdjustChecked_called = true
        return isDailyAdjustChecked_stub!
    }
}
