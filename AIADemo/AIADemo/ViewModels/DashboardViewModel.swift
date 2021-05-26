//
//  DashboardViewModel.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import Foundation

class DashboardViewModel {
    
    //MARK:- variables and initializers
    var dashboardProtocol: DashboardViewModelProtocol?
    var searchProtocol: ViewModelProtocol?
    var router:RouterProtocol!
    
    var dashboardDataSource:[Search]!
    var isIntraday:Bool!
    var dailyAdj_CheckIndexes:[Int]!
    
    var isSearchDisplayPresented:Bool!
    var searchDataSource:[Search]!
    
    var serviceManager: ServiceManagerProtocol!
    var storeManager: StorageManagerProtocol!
    
    init()  {
        
        router = Router.sharedInstance
        serviceManager = ServiceManager.init()
        storeManager = StorageManager.init()
        dashboardDataSource = storeManager.getDashboardData()
        
        isIntraday = true
        dailyAdj_CheckIndexes = []
        isSearchDisplayPresented = false
        searchDataSource = []
    }
    
    // MARK: - DashboardViewController - Action Handlers
    func searchforCompanies(keyword: String) {
        let trimmedKeyword = keyword.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        if trimmedKeyword != "" {
            if isSearchDisplayPresented == false {
                router.displaySearchView()
                isSearchDisplayPresented = true
            }
            
            searchProtocol?.showLoadingIndicator!()
            serviceManager.search(trimmedKeyword,
                                         onSuccess: { searchResults in
                                            
                                            self.searchDataSource = searchResults
                                            self.searchProtocol?.reloadData()
                                            self.searchProtocol?.hideLoadingIndicator!()
                                         }, onFailure: { error in
                                            
                                            self.dashboardProtocol?.showStaticAlert?(STRINGS.ERROR, message: error.localizedDescription)
                                            self.searchProtocol?.hideLoadingIndicator!()
                                         })
        }
        
    }
    
    func companySelected(at index: Int) {
        
        if isIntraday {
            router.navigateToIntraday(with: dashboardDataSource[index])
        }
        else {
            if dailyAdj_CheckIndexes.contains(index) {
                var count = 0
                for element in dailyAdj_CheckIndexes {
                    if element == index {
                        break
                    }
                    count += 1
                }
                dailyAdj_CheckIndexes.remove(at: count)
                if dailyAdj_CheckIndexes.count == 0 {
                    _clearAndReloadCollection()
                } else {
                    dashboardProtocol?.reloadData()
                    dashboardProtocol?.isRightBarButtonHidden(isHidden: false)
                }
            } else {
                dailyAdj_CheckIndexes.append(index)
                if dailyAdj_CheckIndexes.count == 3 {
                    let searches:[Search] = [dashboardDataSource[dailyAdj_CheckIndexes[0]], dashboardDataSource[dailyAdj_CheckIndexes[1]], dashboardDataSource[dailyAdj_CheckIndexes[2]]]
                    router.navigateToDailyAdj(with: searches)
                    self._clearAndReloadCollection()
                } else {
                    dashboardProtocol?.reloadData()
                    dashboardProtocol?.isRightBarButtonHidden(isHidden: false)
                }
            }
        }
    }
     
    func segmentValueChange(index:Int) {
        if index == 0 {
            isIntraday = true
        } else {
            isIntraday = false
        }
        _clearAndReloadCollection()
    }
    
    func removeSearchItem(at index:Int) {
        
        let data = storeManager.deleteFromDashboardData(object: dashboardDataSource[index])
        dashboardDataSource = data
        if dashboardDataSource.count > 0 {
            _clearAndReloadCollection()
            
        } else {
            dashboardProtocol?.hideCollectionView()
        }
        
    }
    
    func routeTosettingsView() {
        
        router.navigateToSettings()
    }
    
    func routeToDailyView() {
        var searches:[Search] = []
        for element in dailyAdj_CheckIndexes {
            searches.append(dashboardDataSource[element])
        }
        router.navigateToDailyAdj(with: searches)
        _clearAndReloadCollection()
    }
    
    // MARK: - DashboardViewController - Data Handlers
    func getDashboardCompaniesCount() -> Int {
        return dashboardDataSource.count
    }
    
    func getDashboardCompanyName(for index:Int) -> String {
        return dashboardDataSource[index].name
    }
    
    func getDashboardCompanySymbol(for index:Int) -> String {
        return dashboardDataSource[index].symbol
    }
    
    func isDailyAdjustChecked(index:Int) ->  Bool {
        
        if !isIntraday &&  dailyAdj_CheckIndexes.contains(index) {
            return true
        }
        return false
    }
    
    // MARK: - SearchDisplayViewController - Action Handlers
    func searchDisappeared() {
        
        isSearchDisplayPresented = false
        dashboardProtocol?.dismissSearchKeyboard()
    }
    
    func searchSelected(index: Int) {
        
        let search = searchDataSource[index]

        var isElementAlreadyAdded = false
        for eachElement in dashboardDataSource {
            if search.symbol == eachElement.symbol {
                isElementAlreadyAdded = true
                break
            }
        }
        if isElementAlreadyAdded {
            
            self.searchProtocol?.showStaticAlert!(STRINGS.ALREADY_ADDED_TEXT, message: "")
        } else {
            
            let title = STRINGS.ADD_TO_DASHBOARD1 + search.symbol + STRINGS.ADD_TO_DASHBOARD2
            self.searchProtocol?.showDoubleActionAlert!(title, message: "", firstTitle: STRINGS.YES, secondTitle: STRINGS.NO, onfirstClick: {
                self.router.hideSearchView()
                self.dashboardProtocol?.clearSearchText()
                self.dashboardDataSource = self.storeManager.saveToDashboardData(object: search)
                self._clearAndReloadCollection()
            }, onSecondClick: {
                self.router.hideSearchView()
                self.dashboardProtocol?.clearSearchText()
            })
        }
    }
    
    // MARK: - SearchDisplayViewController - Data Handlers
    func getSearchCompaniesCount() -> Int {
        return searchDataSource.count
    }
    
    func getSearchCompanyName(for index:Int) -> String {
        return searchDataSource[index].name
    }
    
    func getSearchCompanySymbol(for index:Int) -> String {
        return searchDataSource[index].symbol
    }
    
    // MARK: - Private functions
    private func _clearAndReloadCollection() {
        dailyAdj_CheckIndexes = []
        dashboardProtocol?.reloadData()
        dashboardProtocol?.isRightBarButtonHidden(isHidden: true)
    }
}
