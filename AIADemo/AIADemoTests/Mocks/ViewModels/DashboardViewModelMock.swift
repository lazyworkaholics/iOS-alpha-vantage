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
    
    var is_companySelected_called = false
    
    var is_searchDisappeared_called = false
    
    var is_getSearchCompaniesCount_called = false
    var getSearchCompaniesCount_mock:Int?

    var is_getSearchCompanyName_callld = false
    var getSearchCompanyName_mock:String?

    var is_getSearchCompanySymbol_called = false
    var getSearchCompanySymbol_mock:String?

    var is_searchSelected_called = false
    
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
    
    override func companySelected(at index: Int) {
        is_companySelected_called = true
    }
    
    override func searchDisappeared() {
        is_searchDisappeared_called = true
    }
    
    override func getSearchCompaniesCount() -> Int {
        is_getSearchCompaniesCount_called = true
        return getSearchCompaniesCount_mock!
    }
    
    override func getSearchCompanyName(for index: Int) -> String {
        is_getSearchCompanyName_callld = true
        return getSearchCompanyName_mock!
    }
    
    override func getSearchCompanySymbol(for index: Int) -> String {
        is_getSearchCompanySymbol_called = true
        return getSearchCompanySymbol_mock!
    }
    
    override func searchSelected(index: Int) {
        is_searchSelected_called = true
    }
}
