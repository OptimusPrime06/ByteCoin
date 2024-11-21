//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Gulliver Raed on 10/15/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let currency : String
    let rate : Double
    var lastPrice : String {
        return String(format: "%.2f", rate)
    }
}
