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
    var dashboardDataSource:[Search] = []
    var isIntraday:Bool = true
    
    var searchDisplayController: SearchDisplayViewController?
    var isSearchDisplayPresented = false
    var searchDataSource:[Search] = []
    
    var router:RouterProtocol = Router.sharedInstance
    
    var dailyAdj_CheckIndexes:[Int] = []
    
    // MARK: - dashboard functions
    init()  {
        
        self.dashboardDataSource = StorageManager.init().getDashboardData()
    }
    
    func searchforCompanies(keyword: String) {
        
        if searchDisplayController == nil {
            searchDisplayController = SearchDisplayViewController.initWithViewModel(self)
        }
        if isSearchDisplayPresented == false {
            dashboardProtocol?.displaySearch(controller: searchDisplayController!)
            isSearchDisplayPresented = true
        }
        
        searchDisplayController?.showLoadingIndicator()
        if keyword == "" {
            
            searchDataSource = []
            searchDisplayController?.reloadData()
            self.searchDisplayController?.hideLoadingIndicator()
        } else {
            
            ServiceManager.init().search(keyword,
                                         onSuccess: { searchResults in
                                            
                                            self.searchDataSource = searchResults
                                            self.searchDisplayController?.reloadData()
                                            self.searchDisplayController?.hideLoadingIndicator()
                                         }, onFailure: { error in
                                            
                                            self.dashboardProtocol?.showStaticAlert?(STRINGS.ERROR, message: error.localizedDescription)
                                            self.searchDisplayController?.hideLoadingIndicator()
                                         })
        }
    }
    
    func companySelected(index: Int) {
        
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
                    self._clearAndReloadCollection()
                } else {
                    dashboardProtocol?.showCollectionView()
                    dashboardProtocol?.isRightBarButtonHidden(isHidden: false)
                }
            } else {
                dailyAdj_CheckIndexes.append(index)
                if dailyAdj_CheckIndexes.count == 3 {
                    let searches:[Search] = [dashboardDataSource[dailyAdj_CheckIndexes[0]], dashboardDataSource[dailyAdj_CheckIndexes[1]], dashboardDataSource[dailyAdj_CheckIndexes[2]]]
                    router.navigateToDailyAdj(with: searches)
                    self._clearAndReloadCollection()
                } else {
                    dashboardProtocol?.showCollectionView()
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
        
        let data = StorageManager.init().deleteFromDashboardData(object: dashboardDataSource[index])
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
    
    // MARK: - search custom functions
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
            
            self.searchDisplayController?.showStaticAlert("This company is already added to your dashboard", message: "")
        } else {
            
            let title = "Do you want to add " + search.symbol + " to your dashboard"
            self.searchDisplayController?.showDoubleActionAlert(title, message: "", firstTitle: STRINGS.YES, secondTitle: STRINGS.NO, onfirstClick: {
                
                self.dashboardProtocol?.hideSearch(controller: self.searchDisplayController!)
                self.dashboardProtocol?.clearSearchText()
                self.dashboardDataSource = StorageManager.init().saveToDashboardData(object: search)
                self._clearAndReloadCollection()
            }, onSecondClick: {
                
                self.dashboardProtocol?.hideSearch(controller: self.searchDisplayController!)
                self.dashboardProtocol?.clearSearchText()
            })
        }
    }
    
    func isDailyAdjustChecked(index:Int) ->  Bool{
        
        if !isIntraday &&  dailyAdj_CheckIndexes.contains(index) {
            return true
        }
        return false
    }
    
    func _clearAndReloadCollection() {
        dailyAdj_CheckIndexes = []
        dashboardProtocol?.showCollectionView()
        dashboardProtocol?.isRightBarButtonHidden(isHidden: true)
    }
}
