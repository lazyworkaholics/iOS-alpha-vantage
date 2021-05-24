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
    var router:RouterProtocol = Router.sharedInstance
    
    var dataSource:[Company] = []
    var tailoredData:DailyAdjust?
    var isSortbyOpen = true
    
    // MARK: - daily adj functions
    init(_ search: [Search]) {
        
        self.searches = search
    }
    
    func getData() {
        
        var servicesInProgressCount = searches.count
        
        for search in searches {
            
            ServiceManager.init().getData(search.symbol, isIntraday: false, onSuccess: { [self] company in
                
                servicesInProgressCount -= 1
                self.dataSource.append(company)
                if servicesInProgressCount == 0 {
                    self.parseData()
                }
            }, onFailure: { error in
                
                servicesInProgressCount -= 1
                if servicesInProgressCount == 0 {
                    if self.dataSource.count == 0 {
                        self.dailyAdjProtocol?.showStaticAlert?(STRINGS.ERROR, message: error.localizedDescription)
                    } else {
                        self.parseData()
                    }
                }
            })
        }
    }
    
    func parseData() {
        
        tailoredData = DailyAdjust.init()
        tailoredData?.c1 = dataSource[0].metadata?.symbol ?? "-"
        tailoredData?.c2 = dataSource[1].metadata?.symbol ?? "-"
        tailoredData?.c3 = dataSource[2].metadata?.symbol ?? "-"
        
        let c1Candles = dataSource[0].getCandles(.date)
        let c2Candles = dataSource[1].getCandles(.date)
        let c3Candles = dataSource[1].getCandles(.date)
        
        var compare_candles:[Candle_Compare] = []
        for index in 0...c1Candles.count-1 {
            var candle_adj = Candle_Compare.init()
            candle_adj.open_c1 = String(c1Candles[index].open)
            candle_adj.open_c2 = String(c2Candles[index].open)
            candle_adj.open_c3 = String(c3Candles[index].open)
            candle_adj.low_c1 = String(c1Candles[index].low)
            candle_adj.low_c2 = String(c2Candles[index].low)
            candle_adj.low_c3 = String(c3Candles[index].low)
            candle_adj.date = c1Candles[index].getTimeStamp(timeZone: (dataSource[0].metadata?.timezone)!, isIntraday: false)
            compare_candles.append(candle_adj)
        }
        tailoredData?.candles = compare_candles
        
        var headers = ["Date"]
        headers.append(tailoredData!.c1!)
        headers.append(tailoredData!.c2!)
        headers.append(tailoredData!.c3!)
        
        dailyAdjProtocol?.setSegmentHeaders(titles: headers)
        dailyAdjProtocol?.showTableView()
    }
    
    func segmentValueChange(index:Int) {
        if index == 0 {
            isSortbyOpen = true
        } else {
            isSortbyOpen = false
        }
        dailyAdjProtocol?.showTableView()
    }
    
    func getRowCount() -> Int {
        return tailoredData?.candles.count ?? 0
    }
    
    func getData(for index:Int) -> Candle_Compare {
        return tailoredData!.candles[index]
    }
    
    func navigateToDashboard() {
        
        router.backToDashboard()
    }
}
