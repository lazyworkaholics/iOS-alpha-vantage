//
//  DashboardViewController.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 25/05/2021.
//

import XCTest
@testable import AIADemo

class DashboardViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }
    
    func test_initWithViewModel() {
        
        let viewmodel = DashboardViewModel.init()
        let viewController = DashboardViewController.initWithViewModel(viewmodel)
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewmodel.dashboardProtocol)
    }
    
    func test_viewdidLoad() {
        let viewmodel = DashboardViewModel.init()
        let viewController = DashboardViewController.initWithViewModel(viewmodel)
        
        var search = Search.init()
        search.name = "test"
        search.symbol = "symbol"
        viewmodel.dashboardDataSource = [search]
        XCTAssertNil(viewController.navigationItem.leftBarButtonItem)
        viewController.viewDidLoad()
        XCTAssertNotNil(viewController.navigationItem.leftBarButtonItem)
        XCTAssertEqual(viewController.segmentControl.isHidden, false)
        XCTAssertEqual(viewController.collectionView.isHidden, false)
    }
    
    func test_viewdidLoad2() {
        let viewmodel = DashboardViewModel.init()
        let viewController = DashboardViewController.initWithViewModel(viewmodel)
        
        viewmodel.dashboardDataSource = []
        XCTAssertNil(viewController.navigationItem.leftBarButtonItem)
        viewController.viewDidLoad()
        XCTAssertNotNil(viewController.navigationItem.leftBarButtonItem)
        XCTAssertEqual(viewController.segmentControl.isHidden, true)
        XCTAssertEqual(viewController.collectionView.isHidden, true)
    }
    
    func test_settings_buttonAction() {
        
        let viewmodel = DashboardViewModelMock.init()
        let viewController = DashboardViewController.initWithViewModel(viewmodel)
        viewController.settings_buttonAction()
        XCTAssertTrue(viewmodel.is_routeTosettingsView_called)
    }
    
    func test_daily_adjButtonAction() {
        
        let viewmodel = DashboardViewModelMock.init()
        let viewController = DashboardViewController.initWithViewModel(viewmodel)
        viewController.dailyAdj_buttonAction()
        XCTAssertTrue(viewmodel.is_routeToDailyView_called)
    }
    
    func test_segmentToggle() {
        let viewmodel = DashboardViewModelMock.init()
        let viewController = DashboardViewController.initWithViewModel(viewmodel)
        
        let stubSegment = UISegmentedControl()
        stubSegment.selectedSegmentIndex = 0
        viewController.segmentToggle(stubSegment)
        
        XCTAssertTrue(viewmodel.is_segmentValueChange_called)
    }
    
    func test_isRightBarButtonHidden() {
        let viewmodel = DashboardViewModel.init()
        let viewController = DashboardViewController.initWithViewModel(viewmodel)
        
        viewController.isRightBarButtonHidden(isHidden: true)
        XCTAssertNil(viewController.navigationItem.rightBarButtonItem)
        
        viewController.isRightBarButtonHidden(isHidden: false)
        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
        
        let viewcontroller2 = SearchDisplayViewController.init()
        XCTAssertEqual(viewController.adaptivePresentationStyle(for: UIPresentationController.init(presentedViewController: viewController, presenting: viewcontroller2)), UIModalPresentationStyle.none)
    }
    
    func test_textFieldDidBeginEditing() {
        
        let viewmodel = DashboardViewModelMock.init()
        let viewController = DashboardViewController.initWithViewModel(viewmodel)
        let textfield = UITextField.init()
        viewController.textFieldDidBeginEditing(textfield)
        
        XCTAssertTrue(viewmodel.is_searchforCompanies_called)
    }
    
    
    /*
    func test_collectionView_datasources() {
        
        let viewmodel = DashboardViewModelMock.init()
//        let viewController = DashboardViewController.initWithViewModel(viewmodel)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        viewController.viewModel = viewmodel
        
        var itemsCount_stub = 100
        viewmodel.itemsCount_stub = itemsCount_stub
        let collectionView = viewController.collectionView!
        XCTAssertEqual(viewController.collectionView(collectionView, numberOfItemsInSection: 0), itemsCount_stub)
    }
    
    func test_collectionView_CellforRow() {
        
        let viewmodel = DashboardViewModelMock.init()
//        let viewController = DashboardViewController.initWithViewModel(viewmodel)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        viewController.viewModel = viewmodel
        
        let getDashboardCompanyName_stub = "testName"
        viewmodel.getDashboardCompanyName_stub = getDashboardCompanyName_stub
        let getDashboardCompanySymbol_stub = "testSymbol"
        viewmodel.getDashboardCompanySymbol_stub = getDashboardCompanySymbol_stub
        let isDailyAdjustChecked_stub = false
        viewmodel.isDailyAdjustChecked_stub = isDailyAdjustChecked_stub
        let cell = viewController.collectionView(viewController.collectionView, cellForItemAt: IndexPath.init(item: 0, section: 0))
        
        XCTAssertNotNil(cell)
        XCTAssertTrue(viewmodel.is_getDashboardCompanyName_called)
        XCTAssertTrue(viewmodel.is_getDashboardCompanySymbol_called)
        XCTAssertTrue(viewmodel.is_DailyAdjustChecked_called)
    }
    
    /*
     searchTextChange
     DashboardViewController: DashboardViewModelProtocol
     isRightBarButtonHidden
     showCollectionView
     hideCollectionView
     showStaticAlert
     dismissSearchKeyboard
     clearSearchText
     
     collectinview row
     colectionview items
    -didselectitem at
     - delete button action
 
 */
 */

}
