//
//  IntradayViewControllerTests.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 26/05/2021.
//

import XCTest
@testable import AIADemo

class IntradayViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }
    
    func test_initWithViewModel() {
        var search = Search.init()
        search.symbol = "Test Symbol"
        let viewmodel = IntradayViewModel.init(search)
        let viewController = IntradayViewController.initWithViewModel(viewmodel)
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewmodel.intradayProtocol)
    }
    
    func test_viewdidLoad() {
        let viewmodel = IntradayViewModel.init(Search.init())
        var search = Search.init()
        search.symbol = "Test Symbol"
        viewmodel.search = search
        viewmodel.sortedCandles = []
        
        var mockServiceManager = ServiceManagerMock.init()
        mockServiceManager.isServiceCallSuccess = false
        let mock_error =  NSError.init(domain: "com.testingErrorDomain", code: 11010101843834, userInfo: [NSLocalizedDescriptionKey:"Mock constructed Error"])
        mockServiceManager.mock_error = mock_error
        
        viewmodel.serviceManager = mockServiceManager
        
        let viewController = IntradayViewController.initWithViewModel(viewmodel)
        XCTAssertNil(viewController.navigationItem.leftBarButtonItem)
        viewController.loadView()
        viewController.viewDidLoad()
        XCTAssertNotNil(viewController.navigationItem.leftBarButtonItem)
    }
    
    func test_backButtonAction() {
        var search = Search.init()
        search.symbol = "Test Symbol"
        let intradayViewModel = IntradayViewModelMock.init(search)
        let viewController = IntradayViewController.initWithViewModel(intradayViewModel)
        viewController.back_buttonAction()
        
        XCTAssertTrue(intradayViewModel.is_routeToDashboard_Called)
    }
    
    func test_SortIdChange() {
        var search = Search.init()
        search.symbol = "Test Symbol"
        let intradayViewModel = IntradayViewModelMock.init(search)
        let viewController = IntradayViewController.initWithViewModel(intradayViewModel)
        viewController.loadView()
        viewController.reloadData()
        viewController.segmentToggle(viewController.segmentControl)
        
        XCTAssertTrue(intradayViewModel.is_sortIDChange_Called)
    }
    
    func test_cellForRow()  {
        var search = Search.init()
        search.symbol = "Test Symbol"
        let intradayViewModel = IntradayViewModelMock.init(search)
        intradayViewModel.getValueText = "Test Return Value"
        let viewController = IntradayViewController.initWithViewModel(intradayViewModel)
        viewController.loadView()
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath.init(row: 0, section: 0)) as! IntradayCell
        XCTAssertEqual(cell.open_lbl.text, "Test Return Value")
        viewController.tableView(viewController.tableView, didSelectRowAt: IndexPath.init(row: 0, section: 0))
    }
}
