//
//  ServiceManager.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 21/05/2021.
//

import Foundation

struct ServiceManager: ServiceManagerProtocol   {
    
    var networkManager:NetworkManagerProtocol

    init() {
        self.networkManager = NetworkManager.init()
    }
    
    
    //MARK: - Services
    func getData(_ companySymbol: String, isIntraday: Bool,
                        onSuccess successBlock: @escaping (Company) -> Void,
                        onFailure failureBlock: @escaping (NSError) -> Void) {
        
        var params = [STRINGS.SYMBOL:companySymbol,
                      STRINGS.APIKEY:StorageManager().getAPIKey(),
                      STRINGS.OUTPUTSIZE:StorageManager().getOutputSize()]
        
        if isIntraday {
            params[NETWORK.PARAM_FUNCTION] = NETWORK.PARAM_INTRADAY
            params[STRINGS.INTERVAL] = StorageManager().getInterval().rawValue
        } else {
            params[NETWORK.PARAM_FUNCTION] = NETWORK.PARAM_DAILYADJ
        }
        
        _networkRequest(urlPath: NETWORK.EDIT_SYMBOL_PRE_RELATIVE_PATH,
                        params: params,
                        method: HTTPRequestType.GET,
                        headers: nil,
                        body: nil,
                        onSuccess: {
                            (company) in
                            successBlock(company)
                        },
                        onFailure: {
                            (error) in
                            failureBlock(error)
                        })
    }
    
    func search(_ searchString: String,
                        onSuccess successBlock: @escaping ([Search]) -> Void,
                        onFailure failureBlock: @escaping (NSError) -> Void) {
        
        let params = [NETWORK.PARAM_FUNCTION: NETWORK.PARAM_SEARCH,
                      STRINGS.APIKEY: StorageManager().getAPIKey(),
                      NETWORK.PARAM_KEYWORDS:searchString]
    
        
        _networkRequest(urlPath: NETWORK.EDIT_SYMBOL_PRE_RELATIVE_PATH,
                        params: params,
                        method: HTTPRequestType.GET,
                        headers: nil,
                        body: nil,
                        onSuccess: {
                            (result: [String:[Search]]) in
                            
                            successBlock(result[STRINGS.BEST_MATCHES] ?? [])
                        },
                        onFailure: {
                            (error) in
                            failureBlock(error)
                        })
    }
    
    func getDailyAdjusts(_ companySymbols:[String], onCompletion completionBlock: @escaping (DailyAdjust) -> Void) {
        
        var dailyAdjust:DailyAdjust = DailyAdjust.init()
        let dispatchGroup = DispatchGroup()
        for symbol in companySymbols {
            
            dispatchGroup.enter()
            dailyAdjust.symbols.append(symbol)
            self.getData(symbol, isIntraday: false, onSuccess: {(company) in
                
                dailyAdjust.companies[symbol] = company
                dispatchGroup.leave()
            }, onFailure: {(error) in
                
                dailyAdjust.errors[symbol] = error
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.notify(queue: .main) {
            
            var dates:[String] = []
            var parsedData:[String:[String:Candle_Lite]] = [:]
            for companyKeyValue in dailyAdjust.companies {
                
                if dailyAdjust.timeZone == nil {
                    dailyAdjust.timeZone = (companyKeyValue.value.metadata?.timezone)
                }
                
                var lite_candles:[String:Candle_Lite] = [:]
                for candle in companyKeyValue.value.candles {
                    let dateString = candle.getTimeStamp(timeZone: (companyKeyValue.value.metadata?.timezone!)!, isIntraday: false)
                    dates.append(dateString)
                    lite_candles[dateString] = Candle_Lite.init(open: String(candle.open), high: String(candle.high), low: String(candle.low), close: String(candle.close))
                }
                parsedData[companyKeyValue.key] = lite_candles
            }
            
            dailyAdjust.uniqueDates = Array(Set(dates))
            dailyAdjust.uniqueDates = dailyAdjust.uniqueDates.sorted(by:{ $0 > $1 })
            dailyAdjust.parsedData = parsedData
            completionBlock(dailyAdjust)
        }
    }
    
    
    private func _networkRequest<T1:Decodable>(urlPath:String,
                                           params: [String: String]?,
                                           method: HTTPRequestType,
                                           headers: [String: String]?,
                                           body: Data?,
                                           onSuccess successBlock:@escaping (T1)->Void,
                                           onFailure failureBlock:@escaping (NSError)->Void) {
        networkManager.httpRequest(urlPath,
                                   params: params,
                                   method: method,
                                   headers: headers,
                                   body: body,
                                   onSuccess: { (data) in
                                    
                                    let decoder = JSONDecoder.init()
                                    do {
                                        let transformedData =  try decoder.decode(T1.self, from: data)
                                        successBlock(transformedData)
                                    } catch {
                                        failureBlock(error as NSError)
                                    }
        },
                                   onFailure: { (error) in
                                    
                                    failureBlock(error)
        })
    }
}
