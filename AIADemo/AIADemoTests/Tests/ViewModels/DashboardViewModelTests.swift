//
//  DashboardViewModelTests.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 25/05/2021.
//

import XCTest
@testable import AIADemo

class DashboardViewModelTests: XCTestCase {
    
//    var mock_company:Company?
//    var mock_search:Search?
//    var mock_error:NSError?

    override func setUpWithError() throws {
        
        
//        let text = "{\"Meta Data\":{\"1. Information\":\"Daily Time Series with Splits and Dividend Events\",\"2. Symbol\":\"TSLA\",\"3. Last Refreshed\":\"2021-05-21\",\"4. Output Size\":\"Compact\",\"5. Time Zone\": \"US/Eastern\"},\"Time Series (5min)\":{\"2021-05-20 20:00:00\":{\"1. open\":\"596.11\",\"2. high\":\"596.68\",\"3. low\":\"543.33\",\"4. close\":\"580.88\",\"5. volume\": \"14129\"},\"2021-05-20 19:00:00\":{\"1. open\":\"570.11\",\"2. high\":\"592.68\",\"3. low\":\"543.30\",\"4. close\":\"570.88\",\"5. volume\": \"15000\"}}}"
//        let searchText = "{\"1. symbol\":\"test symbol\", \"2. name\":\"test name\"}"
//        let utf8str = text.data(using: .utf8)
//        let utf8str2 = searchText.data(using: .utf8)
//        do {
//            let decoder = JSONDecoder.init()
//            mock_company = try decoder.decode(Company.self, from: utf8str!)
//            let search = try decoder.decode(Search.self, from: utf8str2!)
//            mock_search = search
//        } catch {
//            XCTFail("init with coder should not fail with an exception for this data")
//        }
        
    }

    override func tearDownWithError() throws {

//        mock_company = nil
//        mock_error = nil
//        mock_search = nil
    }
    
    func testDashboardViewModelInit() {
        
        let viewmodel = DashboardViewModel.init()
        XCTAssertNotNil(viewmodel.router)
        XCTAssertNotNil(viewmodel.dashboardDataSource)
    }
    
    func test_searchForCompanies_empty_searchString() {
        
        let viewmodel = DashboardViewModel.init()
        let routerMock = RouterMock.init()
        viewmodel.router = routerMock
        let mockSearchProtocol = SearchProtocolMock.init()
        viewmodel.searchProtocol = mockSearchProtocol
        
        // when searchForCompanies is called with empty text
        // searchPrototocol's - showLoadingIndicator, reloadData, hideloadingIndicator should be invoked
        // router's - displaySearch should be invoked
        viewmodel.searchforCompanies(keyword: "")
        
        XCTAssertTrue(mockSearchProtocol.is_showLoadingIndicator_Called, "showLoadingIndicator of SearchDisplayViewController should be invoked")
        XCTAssertTrue(mockSearchProtocol.is_reloadData_called, "reloadData of SearchDisplayViewController should be invoked")
        XCTAssertTrue(mockSearchProtocol.is_hideLoadingIndicator_Called, "hideLoadingIndicator of SearchDisplayViewController should be invoked")
        XCTAssertTrue(routerMock.is_displaySearchView_called, "displaySearchView of Router should be invoked")
        
    }
    
    func test_searchForCompanies_in_Service_Call_Failure() {
        
        let viewmodel = DashboardViewModel.init()
        
        let routerMock = RouterMock.init()
        viewmodel.router = routerMock
        
        let mock_error =  NSError.init(domain: "com.testingErrorDomain", code: 11010101843834, userInfo: [NSLocalizedDescriptionKey:"Mock constructed Error"])
        var mock_service = ServiceManagerMock.init()
        mock_service.mock_error = mock_error
        mock_service.isServiceCallSuccess = false
        viewmodel.serviceManager = mock_service
        
        let mockSearchProtocol = SearchProtocolMock.init()
        viewmodel.searchProtocol = mockSearchProtocol
        
        let mockDashboardProtocol = DashboardProtocolMock.init()
        viewmodel.dashboardProtocol = mockDashboardProtocol
        
        // when searchForCompanies is called with valid text and service manager returns error
        // searchPrototocol's - showLoadingIndicator, hideloadingIndicator should be invoked
        // router's - displaySearch should be invoked
        // dashboardPrototocl's - showStaticAlert should be invoked
        viewmodel.searchforCompanies(keyword: "test")
        
        XCTAssertTrue(mockSearchProtocol.is_showLoadingIndicator_Called, "showLoadingIndicator of SearchDisplayViewController should be invoked")
        XCTAssertTrue(mockSearchProtocol.is_hideLoadingIndicator_Called, "hideLoadingIndicator of SearchDisplayViewController should be invoked")
        XCTAssertTrue(routerMock.is_displaySearchView_called, "displaySearchView of Router should be invoked")
        XCTAssertTrue(mockDashboardProtocol.is_showStaticAlert_Called, "showStaticAlert of DashboardViewController should be invoked")
    }
    
    func test_searchForCompanies_in_Service_Call_Success() {
        
        let viewmodel = DashboardViewModel.init()
        
        let routerMock = RouterMock.init()
        viewmodel.router = routerMock
        
        let searchText = "{\"1. symbol\":\"test symbol\", \"2. name\":\"test name\"}"
        let utf8str2 = searchText.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let search = try decoder.decode(Search.self, from: utf8str2!)
            
            var mock_service = ServiceManagerMock.init()
            mock_service.mock_searches = [search]
            mock_service.isServiceCallSuccess = true
            viewmodel.serviceManager = mock_service
            
            let mockSearchProtocol = SearchProtocolMock.init()
            viewmodel.searchProtocol = mockSearchProtocol
            // when searchForCompanies is called with valid text and service manager returns success with valid data
            // searchPrototocol's - showLoadingIndicator, hideloadingIndicator should be invoked
            // router's - displaySearch should be invoked
            // dashboardPrototocl's - showStaticAlert should be invoked
            viewmodel.searchforCompanies(keyword: "test")
            
            XCTAssertTrue(mockSearchProtocol.is_showLoadingIndicator_Called, "showLoadingIndicator of SearchDisplayViewController should be invoked")
            XCTAssertTrue(mockSearchProtocol.is_reloadData_called, "reloadData of SearchDisplayViewController should be invoked")
            XCTAssertTrue(mockSearchProtocol.is_hideLoadingIndicator_Called, "hideLoadingIndicator of SearchDisplayViewController should be invoked")
            XCTAssertTrue(routerMock.is_displaySearchView_called, "displaySearchView of Router should be invoked")
            
            XCTAssertEqual(viewmodel.searchDataSource.count, 1, "Data should be returned correct")
            XCTAssertEqual(viewmodel.searchDataSource[0].symbol, search.symbol, "Data should be returned correct")
            XCTAssertEqual(viewmodel.searchDataSource[0].name, search.name, "Data should be returned correct")
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
    
    func test_segmentValueChange_WhenIndex_0() {
        
        let viewmodel = DashboardViewModel.init()
        
        let mockDashboardProtocol = DashboardProtocolMock.init()
        viewmodel.dashboardProtocol = mockDashboardProtocol
        
        // when segmentValueChange is called with index:0
        // searchPrototocol's - isIntraDay should be set to true and dailyAdj_CheckIndexes should be []
        // dashboardPrototocl's - showCollectionView and isRightBarButtonHidden should be invoked
        viewmodel.segmentValueChange(index: 0)
        
        XCTAssertEqual(viewmodel.isIntraday, true, "isIntraDay should be set to true")
        XCTAssertEqual(viewmodel.dailyAdj_CheckIndexes, [], "dailyAdj_CheckIndexes should be emptied")
        XCTAssertTrue(mockDashboardProtocol.is_showCollectionView_Called, "showCollectionView of DashboardViewController should be invoked")
        XCTAssertTrue(mockDashboardProtocol.is_isRightBarButtonHidden_Called, "isRightBarButtonHidden of DashboardViewController should be invoked")
    }
    
    func test_segmentValueChange_WhenIndex_1() {
        let viewmodel = DashboardViewModel.init()
        
        let mockDashboardProtocol = DashboardProtocolMock.init()
        viewmodel.dashboardProtocol = mockDashboardProtocol
        
        // when segmentValueChange is called with index:1
        // searchPrototocol's - isIntraDay should be set to false and dailyAdj_CheckIndexes should be []
        // dashboardPrototocl's - showCollectionView and isRightBarButtonHidden should be invoked
        viewmodel.segmentValueChange(index: 1)
        
        XCTAssertEqual(viewmodel.isIntraday, false, "isIntraDay should be set to true")
        XCTAssertEqual(viewmodel.dailyAdj_CheckIndexes, [], "dailyAdj_CheckIndexes should be emptied")
        XCTAssertTrue(mockDashboardProtocol.is_showCollectionView_Called, "showCollectionView of DashboardViewController should be invoked")
        XCTAssertTrue(mockDashboardProtocol.is_isRightBarButtonHidden_Called, "isRightBarButtonHidden of DashboardViewController should be invoked")
    }
    
    func test_segmentValueChange_WhenIndex_RandomNumber() {
        let viewmodel = DashboardViewModel.init()
        
        let mockDashboardProtocol = DashboardProtocolMock.init()
        viewmodel.dashboardProtocol = mockDashboardProtocol
        
        // when segmentValueChange is called with index:<random number> should behave same as index 1
        viewmodel.segmentValueChange(index: 3846)
        
        XCTAssertEqual(viewmodel.isIntraday, false, "isIntraDay should be set to true")
        XCTAssertEqual(viewmodel.dailyAdj_CheckIndexes, [], "dailyAdj_CheckIndexes should be emptied")
        XCTAssertTrue(mockDashboardProtocol.is_showCollectionView_Called, "showCollectionView of DashboardViewController should be invoked")
        XCTAssertTrue(mockDashboardProtocol.is_isRightBarButtonHidden_Called, "isRightBarButtonHidden of DashboardViewController should be invoked")
    }
    
    func test_companySelected_intraday() {
        let viewmodel = DashboardViewModel.init()
        viewmodel.isIntraday = true
        let routerMock = RouterMock.init()
        viewmodel.router = routerMock
        
        //when companySelected with an index, navigateToIntraday should be called with that particular search item
        var search1 = Search.init()
        search1.name = "Name1"
        search1.symbol = "symboll1"
        
        var search2 = Search.init()
        search2.name = "Name2"
        search2.symbol = "symboll2"
        
        var search3 = Search.init()
        search3.name = "Name3"
        search3.symbol = "symboll3"
        viewmodel.dashboardDataSource = [search1,search2,search3]
        
        viewmodel.companySelected(at: 1)
        
        XCTAssertTrue(routerMock.is_navigateToIntraday_called, "navigateToIntraday of Router should be invoked")
        XCTAssertEqual(routerMock.navigateToIntraday_search_received?.name, search2.name, "Search object should be passed correctly")
    }
    
    func test_companySelected_not_intraday_uncheck_existing_dailyAdj() {
        let viewmodel = DashboardViewModel.init()
        viewmodel.isIntraday = false
        viewmodel.dailyAdj_CheckIndexes = [1]
        
        let routerMock = RouterMock.init()
        viewmodel.router = routerMock
        
        let mockDashboardProtocol = DashboardProtocolMock.init()
        viewmodel.dashboardProtocol = mockDashboardProtocol
        
        // when companySelected with an isIntraday false and dailyAdj_CheckIndexes has only one index and that index itself is selected
        // searchPrototocol's - dailyAdj_CheckIndexes should be set to []
        // dashboardPrototocl's - showCollectionView and isRightBarButtonHidden should be invoked
        var search1 = Search.init()
        search1.name = "Name1"
        search1.symbol = "symboll1"
        
        var search2 = Search.init()
        search2.name = "Name2"
        search2.symbol = "symboll2"
        
        var search3 = Search.init()
        search3.name = "Name3"
        search3.symbol = "symboll3"
        viewmodel.dashboardDataSource = [search1,search2,search3]
        
        viewmodel.companySelected(at: 1)
        
        XCTAssertEqual(viewmodel.dailyAdj_CheckIndexes, [], "dailyAdj_CheckIndexes should be emptied")
        XCTAssertTrue(mockDashboardProtocol.is_showCollectionView_Called, "showCollectionView of DashboardViewController should be invoked")
        XCTAssertTrue(mockDashboardProtocol.is_isRightBarButtonHidden_Called, "isRightBarButtonHidden of DashboardViewController should be invoked")
    }
    
    func test_companySelected_not_intraday_uncheck_existing_dailyAdj_2() {
        let viewmodel = DashboardViewModel.init()
        viewmodel.isIntraday = false
        viewmodel.dailyAdj_CheckIndexes = [1, 2, 3]
        
        let routerMock = RouterMock.init()
        viewmodel.router = routerMock
        
        let mockDashboardProtocol = DashboardProtocolMock.init()
        viewmodel.dashboardProtocol = mockDashboardProtocol
        
        // when companySelected with an isIntraday false and dailyAdj_CheckIndexes has only 3 indexes and one of the index is selected
        // dashboardPrototocl's - showCollectionView and isRightBarButtonHidden should be invoked
        var search1 = Search.init()
        search1.name = "Name1"
        search1.symbol = "symboll1"
        
        var search2 = Search.init()
        search2.name = "Name2"
        search2.symbol = "symboll2"
        
        var search3 = Search.init()
        search3.name = "Name3"
        search3.symbol = "symboll3"
        viewmodel.dashboardDataSource = [search1,search2,search3]
        
        viewmodel.companySelected(at: 2)
        
        XCTAssertTrue(mockDashboardProtocol.is_showCollectionView_Called, "showCollectionView of DashboardViewController should be invoked")
        XCTAssertTrue(mockDashboardProtocol.is_isRightBarButtonHidden_Called, "isRightBarButtonHidden of DashboardViewController should be invoked")
    }
    
    func test_companySelected_dailyAdj_selecting_third_element_case() {
        let viewmodel = DashboardViewModel.init()
        viewmodel.isIntraday = false
        viewmodel.dailyAdj_CheckIndexes = [1, 2]
        
        let routerMock = RouterMock.init()
        viewmodel.router = routerMock
        
        let mockDashboardProtocol = DashboardProtocolMock.init()
        viewmodel.dashboardProtocol = mockDashboardProtocol
        
        // when companySelected with an isIntraday false and dailyAdj_CheckIndexes has 2 indexes and 3rd index is passed as a parameter
        // Router's navigateToDailyAdj should be invoked
        var search1 = Search.init()
        search1.name = "Name1"
        search1.symbol = "symboll1"
        
        var search2 = Search.init()
        search2.name = "Name2"
        search2.symbol = "symboll2"
        
        var search3 = Search.init()
        search3.name = "Name3"
        search3.symbol = "symboll3"
        viewmodel.dashboardDataSource = [search1,search2,search3]
        
        viewmodel.companySelected(at: 0)
        
        XCTAssertTrue(routerMock.is_navigateToDailyAdj_called, "Router's navigateToDailyAdj should be invoked")
    }
    
    func test_companySelected_dailyAdj_selecting_1or2_element_case() {
        let viewmodel = DashboardViewModel.init()
        viewmodel.isIntraday = false
        viewmodel.dailyAdj_CheckIndexes = [1]
        
        let routerMock = RouterMock.init()
        viewmodel.router = routerMock
        
        let mockDashboardProtocol = DashboardProtocolMock.init()
        viewmodel.dashboardProtocol = mockDashboardProtocol
        
        // when companySelected with an isIntraday false and dailyAdj_CheckIndexes has 1 indexes and 2nd index is passed as a parameter
        // DashboardViewController's showCollectionView and isRightBarButtonHidden should be invoked
        var search1 = Search.init()
        search1.name = "Name1"
        search1.symbol = "symboll1"
        
        var search2 = Search.init()
        search2.name = "Name2"
        search2.symbol = "symboll2"
        
        var search3 = Search.init()
        search3.name = "Name3"
        search3.symbol = "symboll3"
        viewmodel.dashboardDataSource = [search1,search2,search3]
        
        viewmodel.companySelected(at: 0)
        
        XCTAssertTrue(mockDashboardProtocol.is_showCollectionView_Called, "showCollectionView of DashboardViewController should be invoked")
        XCTAssertTrue(mockDashboardProtocol.is_isRightBarButtonHidden_Called, "isRightBarButtonHidden of DashboardViewController should be invoked")
    }
    
    func test_removeSearchItem_case1() {
        
        let viewmodel = DashboardViewModel.init()
        
        let storeageManagerMock = StoreManagerMock.init()
        storeageManagerMock.mock_searches = []
        viewmodel.storeManager = storeageManagerMock
        
        let mockDashboardProtocol = DashboardProtocolMock.init()
        viewmodel.dashboardProtocol = mockDashboardProtocol
        
        var search1 = Search.init()
        search1.name = "Name1"
        search1.symbol = "symboll1"
        viewmodel.dashboardDataSource = [search1]
        
        viewmodel.removeSearchItem(at: 0)
        
        XCTAssertEqual(viewmodel.dashboardDataSource.count, 0, "dashboardDataSource should be matching to that of mock_searches")
        XCTAssertTrue(mockDashboardProtocol.is_hideCollectionView_Called, "hideCollecrtion View of DashboardViewController should be invoked")
    }
    
    func test_removeSearchItem_case2() {
        
        let viewmodel = DashboardViewModel.init()
        
        let storeageManagerMock = StoreManagerMock.init()
        var search1 = Search.init()
        search1.name = "Name1"
        search1.symbol = "symboll1"
        storeageManagerMock.mock_searches = [search1]
        viewmodel.storeManager = storeageManagerMock
        
        let mockDashboardProtocol = DashboardProtocolMock.init()
        viewmodel.dashboardProtocol = mockDashboardProtocol
        viewmodel.dashboardDataSource = [search1]
        
        viewmodel.removeSearchItem(at: 0)

        XCTAssertEqual(viewmodel.dashboardDataSource.count, 1, "dashboardDataSource should be matching to that of mock_searches")
        XCTAssertEqual(viewmodel.dashboardDataSource[0].name, search1.name, "dashboardDataSource should be matching to that of mock_searches")
        XCTAssertTrue(mockDashboardProtocol.is_showCollectionView_Called, "showCollectionView of DashboardViewController should be invoked")
        XCTAssertTrue(mockDashboardProtocol.is_isRightBarButtonHidden_Called, "isRightBarButtonHidden of DashboardViewController should be invoked")
    }
    
    func test_routeToSettingsView() {
        
        let viewmodel = DashboardViewModel.init()
        let routerMock = RouterMock.init()
        viewmodel.router = routerMock
        
        viewmodel.routeTosettingsView()
        
        XCTAssertTrue(routerMock.is_navigateToSettings_called, "navigateToSettings of Router should be invoked")
    }
    
    func test_routeToDailyADJView() {
        
        let viewmodel = DashboardViewModel.init()
        let routerMock = RouterMock.init()
        viewmodel.router = routerMock
        
        let mockDashboardProtocol = DashboardProtocolMock.init()
        viewmodel.dashboardProtocol = mockDashboardProtocol
        
        var search1 = Search.init()
        search1.name = "Name1"
        search1.symbol = "symboll1"
        viewmodel.dashboardDataSource = [search1]
        viewmodel.dailyAdj_CheckIndexes = [0]
        
        viewmodel.routeToDailyView()
        
        XCTAssertTrue(routerMock.is_navigateToDailyAdj_called, "navigateToSettings of Router should be invoked")
    }
    
    func test_DashboardViewController_Data_Handlers() {
        
        let viewmodel = DashboardViewModel.init()
        let mockDashboardProtocol = DashboardProtocolMock.init()
        viewmodel.dashboardProtocol = mockDashboardProtocol
        
        var search1 = Search.init()
        search1.name = "Name1"
        search1.symbol = "symboll1"
        viewmodel.dashboardDataSource = [search1]
        viewmodel.dailyAdj_CheckIndexes = [0]
        viewmodel.isIntraday = false
        
        XCTAssertEqual(viewmodel.getDashboardCompaniesCount(), 1)
        XCTAssertEqual(viewmodel.getDashboardCompanyName(for: 0), "Name1")
        XCTAssertEqual(viewmodel.getDashboardCompanySymbol(for: 0), "symboll1")
        XCTAssertEqual(viewmodel.isDailyAdjustChecked(index: 0), true)
        XCTAssertEqual(viewmodel.isDailyAdjustChecked(index: 1), false)
    }
    
    func test_searchDisappeared() {
        let viewmodel = DashboardViewModel.init()
        let mockDashboardProtocol = DashboardProtocolMock.init()
        viewmodel.dashboardProtocol = mockDashboardProtocol
        
        viewmodel.searchDisappeared()
        XCTAssertEqual(viewmodel.isSearchDisplayPresented, false)
        XCTAssertTrue(mockDashboardProtocol.is_dismissSearchKeyboard_Called, "dismissSearchKeyboard of DashboardViewController should be called")
    }
    
    func test_SearchDisplayViewController_Data_Handlers()  {
        
        let viewmodel = DashboardViewModel.init()
        let mockDashboardProtocol = DashboardProtocolMock.init()
        viewmodel.dashboardProtocol = mockDashboardProtocol
        
        var search1 = Search.init()
        search1.name = "Name1"
        search1.symbol = "symboll1"
        viewmodel.searchDataSource = [search1]
        
        XCTAssertEqual(viewmodel.getSearchCompaniesCount(), 1)
        XCTAssertEqual(viewmodel.getSearchCompanyName(for: 0), "Name1")
        XCTAssertEqual(viewmodel.getSearchCompanySymbol(for: 0), "symboll1")
    }
    
    func test_searchSelected_alreadyAddedCase() {
        let viewmodel = DashboardViewModel.init()
        
        var search1 = Search.init()
        search1.name = "Name1"
        search1.symbol = "symboll1"
        viewmodel.searchDataSource = [search1]
        viewmodel.dashboardDataSource = [search1]
        
        let mockSearchProtocol = SearchProtocolMock.init()
        viewmodel.searchProtocol = mockSearchProtocol
        
        viewmodel.searchSelected(index: 0)
        
        XCTAssertTrue(mockSearchProtocol.is_showStaticAlert_Called, "showStaticAlert on SearchDisplayViewController should be called")
    }
    
    func test_searchSelected_NewItem() {
        let viewmodel = DashboardViewModel.init()
        
        var search1 = Search.init()
        search1.name = "Name1"
        search1.symbol = "symboll1"
        
        var search2 = Search.init()
        search2.name = "Name2"
        search2.symbol = "symboll2"
        viewmodel.searchDataSource = [search2]
        viewmodel.dashboardDataSource = [search1]
        
        let mockSearchProtocol = SearchProtocolMock.init()
        viewmodel.searchProtocol = mockSearchProtocol
        
        viewmodel.searchSelected(index: 0)
        
        XCTAssertTrue(mockSearchProtocol.is_doubleActionAlert_Called, "showDoubleActionAlert on SearchDisplayViewController should be called")
    }


}
