//
//  MockDashboardProtocol.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 25/05/2021.
//

import Foundation
@testable import AIADemo

class DashboardProtocolMock: DashboardViewModelProtocol {
    
    var is_showCollectionView_Called = false
    var is_hideCollectionView_Called = false
    var is_displaySearch_Called = false
    var is_hideSearch_Called = false
    var is_dismissSearchKeyboard_Called = false
    var is_clearSearchText_Called = false
    var is_isRightBarButtonHidden_Called = false
    var is_showStaticAlert_Called = false
    
    func showCollectionView() {
        is_showCollectionView_Called = true
    }
    
    func hideCollectionView() {
        is_hideCollectionView_Called = true
    }
    
    func displaySearch(controller: SearchDisplayViewController) {
        is_displaySearch_Called = true
    }
    
    func hideSearch(controller: SearchDisplayViewController) {
        is_hideSearch_Called = true
    }
    
    func dismissSearchKeyboard() {
        is_dismissSearchKeyboard_Called = true
    }
    
    func clearSearchText() {
        is_clearSearchText_Called = true
    }
    
    func isRightBarButtonHidden(isHidden: Bool) {
        is_isRightBarButtonHidden_Called = true
    }
    
    @objc func showStaticAlert(_ title: String, message: String) {
        is_showStaticAlert_Called = true
    }
}
