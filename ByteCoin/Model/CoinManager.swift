//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {

    func didUpdateRate(_ coinModel: CoinModel?)
    func didFailWithError(_ error: Error)
}

struct CoinManager {
    
    var delegate : CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "apikey=5B69969C-9836-4855-BFD4-98FDEABA6F7E"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
        
    
    func getCoinPrice(for currency: String) {
        let completeURL = "\(baseURL)/\(currency)?\(apiKey)"
        preformRequest(with: completeURL)
    }
    
    func preformRequest(with urlString: String) {
        
        // 1. create URL
        if let url = URL(string: urlString){
            
            // 2. Create Session
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: url) { (data, request, error) in
            
                if error != nil {
                    print(error!)
                    self.delegate?.didFailWithError(error!)
//                    return
                }
                
                if let safeData = data {
//                    let Data = String(data: safeData, encoding: .utf8)
//                    print(Data)
                    if let coinModel = self.parseJSON(safeData){
//                        self.delegate?.didUpdateRate(rate: CoinModel)
                        self.delegate?.didUpdateRate(coinModel)
                    }
                }
            }
            
            // 4. start the task
            task.resume()
        }
    }

    func parseJSON(_ data: Data) -> CoinModel? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let rate = decodedData.rate
            let currency = decodedData.asset_id_quote
            let coinModel = CoinModel(currency: currency, rate: rate)
            return coinModel
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
        
    }
    
}
