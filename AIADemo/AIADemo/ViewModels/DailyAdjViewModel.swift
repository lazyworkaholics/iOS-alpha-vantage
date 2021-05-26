//
//  DailyAdjViewModel.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import Foundation

class DailyAdjViewModel {
    
    //MARK:- variables and initializers
    var dailyAdjProtocol: DailyAdjViewModelProtocol?
    var searches: [Search]
    
    var dataSource:DailyAdjust?
    var compareBy:CompareBy = .open
    
    var router:RouterProtocol!
    var serviceManager: ServiceManagerProtocol!
    
    // MARK: - daily adj functions
    init(_ search: [Search]) {
        
        self.searches = search
        router = Router.sharedInstance
        serviceManager = ServiceManager.init()
    }
    
    // MARK: - DailyAdjViewController - Action Handlers
    func getData() {

        var searchSymbols:[String] = []
        for search in searches {
            searchSymbols.append(search.symbol)
        }
        self.dailyAdjProtocol?.showLoadingIndicator?()
        serviceManager.getDailyAdjusts(searchSymbols) { dailyAdjust in
            
            self.dataSource = dailyAdjust
            self.dailyAdjProtocol?.setSegmentHeaders(titles: self._getHeaders())
            if self.dataSource?.errors.count != self.dataSource?.symbols.count {
                self.dailyAdjProtocol?.reloadData()
            } else {
                let error = self.dataSource?.errors[(self.dataSource?.symbols[0])!]
                self.dailyAdjProtocol?.showStaticAlert?(STRINGS.ERROR, message: error?.localizedDescription ?? ERROR.DESCRIPTION.DAILY_ADJ_ERROR)
            }
            self.dailyAdjProtocol?.hideLoadingIndicator?()
        }
    }
    
    
    func segmentValueChange(index:Int) {
        
        switch index {
        case 0:
            compareBy = .open
            break
        case 1:
            compareBy = .high
            break
        case 2:
            compareBy = .low
            break
        default:
            compareBy = .close
            break
        }
        dailyAdjProtocol?.reloadData()
    }
    
    func routeToDashboard() {
        
        router.backToDashboard()
    }
    
    // MARK: - DailyAdjViewController - Data Handlers
    func getRowCount() -> Int {
        
        return dataSource?.uniqueDates.count ?? 0
    }
        
    func getData(for index:Int) -> [String] {
        
        var array:[String] = []
        
        guard let date_string = dataSource?.uniqueDates[index] else {
            return ["-", "-", "-", "-"]
        }
        
        array.append(date_string)
        for index in 1...3 {
            if (index-1) < (dataSource?.symbols.count ?? 0) {
                let company = dataSource?.parsedData[(dataSource?.symbols[index-1])!]
                let candle = company?[date_string]
                if candle != nil {
                    switch compareBy {
                    case .open:
                        array.append((candle?.open)!)
                        break
                    case .high:
                        array.append((candle?.high)!)
                        break
                    case .low:
                        array.append((candle?.low)!)
                        break
                    case .close:
                        array.append((candle?.close)!)
                        break
                    }
                } else {
                    array.append("-")
                }
            } else {
                array.append("-")
            }
        }
        return array
    }
    
    // MARK: - internal functions
    private func _getHeaders() -> [String] {
        var headers = dataSource?.symbols ?? []
        headers.insert(STRINGS.DATE, at: 0)
        
        while headers.count < 4 {
            headers.append("-")
        }
        return headers
    }
}
