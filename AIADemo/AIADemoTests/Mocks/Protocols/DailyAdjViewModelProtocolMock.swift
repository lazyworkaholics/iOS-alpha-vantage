//
//  DailyAdjViewModelMock.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 26/05/2021.
//

import Foundation
@testable import AIADemo

class DailyAdjViewModelProtocolMock: DailyAdjViewModelProtocol {

    var is_showTableView_called = false
    var is_showLoadingIndicator_Called = false
    var is_hideLoadingIndicator_Called = false
    var is_showStaticAlert_Called = false
    var is_showDoubleActionAlert_Called = false
    var is_setSegmentHeaders_called = false
    
    func showLoadingIndicator() {
        is_showLoadingIndicator_Called = true
    }
    
    func hideLoadingIndicator() {
        is_hideLoadingIndicator_Called = true
    }
    
    func setSegmentHeaders(titles: [String]) {
        is_setSegmentHeaders_called = true
    }
    
    @objc func showStaticAlert(_ title: String, message: String) {
        is_showStaticAlert_Called = true
    }
    
    @objc func showDoubleActionAlert(_ title: String, message: String?, firstTitle:String, secondTitle:String?, onfirstClick:@escaping (() -> Void), onSecondClick:(() -> Void)?) {
        is_showDoubleActionAlert_Called = true
    }
    
    func reloadData() {
        is_showTableView_called = true
    }
}
