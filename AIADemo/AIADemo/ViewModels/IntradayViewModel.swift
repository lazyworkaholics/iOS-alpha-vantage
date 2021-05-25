//
//  IntradayViewModel.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import Foundation

class IntradayViewModel {
    
    //MARK:- variables and initializers
    var intradayProtocol: IntradayViewModelProtocol?
    var search: Search
    var dataSource: Company?
    var sortedCandles: [Candle]?
    var router:RouterProtocol?
    var serviceManager: ServiceManagerProtocol!
    
    // MARK: - intraday functions
    init(_ search: Search) {
        
        self.search = search
        sortedCandles = []
        router = Router.sharedInstance
        serviceManager = ServiceManager.init()
    }
    
    // MARK: - IntradayViewController - Action Handlers
    func getCompanyData() {
        
        self.intradayProtocol?.showLoadingIndicator?()
        serviceManager.getData(search.symbol, isIntraday: true, onSuccess: { company in
            
            if company.errorMessage != nil {
                self.intradayProtocol?.showStaticAlert?(STRINGS.ERROR, message: company.errorMessage!)
            } else {
                self.dataSource = company
                self.sortedCandles = company.getCandles(.date)
                self.intradayProtocol?.showTableView()
            }
            self.intradayProtocol?.hideLoadingIndicator?()
        }, onFailure: { error in
            
            self.intradayProtocol?.showStaticAlert?(STRINGS.ERROR, message: error.localizedDescription)
            self.intradayProtocol?.hideLoadingIndicator?()
        })
    }
    
    func sortIDChange(index: Int) {
        
        switch index {
        case 0:
            sortedCandles = (dataSource?.getCandles(.date)) ?? []
            break
        case 1:
            sortedCandles = (dataSource?.getCandles(.open)) ?? []
            break
        case 2:
            sortedCandles = (dataSource?.getCandles(.high)) ?? []
            break
        case 3:
            sortedCandles = (dataSource?.getCandles(.low)) ?? []
            break
        default:
            sortedCandles = (dataSource?.getCandles(.close)) ?? []
            break
        }
        self.intradayProtocol?.showTableView()
    }
    
    func routeToDashboard() {
        
        router!.backToDashboard()
    }
    
    // MARK: - IntradayViewController - Data Handlers
    func getRowCount() -> Int {
        
        return sortedCandles!.count
    }
    
    func getValue(index:Int, object:SortingID) -> String {
        
        let candle = sortedCandles![index]
        switch object {
        case .date:
            return candle.getTimeStamp(timeZone: (dataSource!.metadata?.timezone)!, isIntraday: true)
        case .open:
            return String(candle.open)
        case .high:
            return String(candle.high)
        case .low:
            return String(candle.low)
        case .close:
            return String(candle.close)
        }
    }
}
