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
    
    var searchDisplayController: SearchDisplayViewController?
    var isSearchDisplayPresented = false
    var searchDataSource:[Search] = []
    
    
    // MARK: - dashboard custom functions
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
    
    // MARK: - search custom functions
    func searchDisappeared() {
        
        isSearchDisplayPresented = false
        dashboardProtocol?.dismissSearchKeyboard()
    }
    
    func searchSelected(index: Int) {
        let search = searchDataSource[index]
        // Check if this element is an already added data
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
                
                // - Reload Collection View
            }, onSecondClick: {
                
                self.dashboardProtocol?.hideSearch(controller: self.searchDisplayController!)
                self.dashboardProtocol?.clearSearchText()
            })
        }
    }
}
