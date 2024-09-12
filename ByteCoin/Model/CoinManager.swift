//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = Bundle.main.object(forInfoDictionaryKey: "CoinAPI API Key") ?? ""
        
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency:String) {
        let urlString = baseURL + "/\(currency)?apiKey=\(apiKey)"

        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                //Format the data we got back as a string to be able to print it.
                let dataAsString = String(data: data!, encoding: .utf8)
         
                if let safeData = data {
                    let bitcoinPrice = self.parseJSON(safeData)
                }
            }
            
            task.resume()
        }
    }

    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodeData.rate
            return lastPrice
        } catch {
//            delegate?.didFailWeatherError(error: error)
            return nil
        }
    }

}
