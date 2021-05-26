//
//  SearchDisplayViewControllerTests.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 26/05/2021.
//

import XCTest
@testable import AIADemo

class SearchDisplayViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func test_view_searchDisappeared() {
        
        let viewmodel = DashboardViewModelMock.init()
        let viewController = SearchDisplayViewController.initWithViewModel(viewmodel)
        XCTAssertNotNil(viewController.viewModel)
        viewController.loadView()
        viewController.showLoadingIndicator()
        viewController.viewDidDisappear(true)
        viewController.hideLoadingIndicator()
        XCTAssert(viewmodel.is_searchDisappeared_called)
    }
    
    func test_tableView_dataSource_delegate() {
        
        let viewmodel = DashboardViewModelMock.init()
        let viewController = SearchDisplayViewController.initWithViewModel(viewmodel)
        viewController.loadView()
        let getSearchCompaniesCount_mock = 14
        viewmodel.getSearchCompaniesCount_mock = getSearchCompaniesCount_mock
        XCTAssertEqual(viewController.tableView(viewController.tableView, numberOfRowsInSection: 0), getSearchCompaniesCount_mock)
        
        let getSearchCompanyName_mock = "Test String"
        let getSearchCompanySymbol_mock = "Test Symbol"
        viewmodel.getSearchCompanyName_mock = getSearchCompanyName_mock
        viewmodel.getSearchCompanySymbol_mock = getSearchCompanySymbol_mock
        
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath.init(row: 0, section: 0)) as! SearchCell
        
        XCTAssertTrue(viewmodel.is_getSearchCompanyName_callld)
        XCTAssertTrue(viewmodel.is_getSearchCompanySymbol_called)
        
        viewController.showStaticAlert("test", message: "mssge")
        XCTAssertEqual(cell.name_lbl.text, getSearchCompanyName_mock)
        XCTAssertEqual(cell.symbol_lbl.text, getSearchCompanySymbol_mock)
        viewController.reloadData()
        viewController.tableView(viewController.tableView, didSelectRowAt: IndexPath.init(row: 0, section: 0))
        XCTAssertTrue(viewmodel.is_searchSelected_called)
    }
}
