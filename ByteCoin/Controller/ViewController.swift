//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var coinManager = CoinManager()
    
    @IBOutlet weak var bitCoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        coinManager.getCoinPrice(for: "USD")
        
    }
}


    //MARK: - UIPickerDataSource
    
    extension ViewController: UIPickerViewDataSource {
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {

            // wants the numbers of coulomns that will be in my UIPicker as output
            return 1
        }

        func pickerView(
            _ pickerView: UIPickerView, numberOfRowsInComponent component: Int
        ) -> Int {
            // wants the number of rows ( elements to be chosen/picked from ) in the UIPicker as output
            return coinManager.currencyArray.count
        }
    }
    

    //MARK: - UIPickerViewDelegate

    extension ViewController: UIPickerViewDelegate {
        
        func pickerView(
            _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return coinManager.currencyArray[row]
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            // print(coinManager.currencyArray[row])
            let selectedCurrency = coinManager.currencyArray[row]
            coinManager.getCoinPrice(for: selectedCurrency)
        }
        
    }


    //MARK: - CoinManager Delegate
    
    extension ViewController: CoinManagerDelegate {
        
        func didUpdateRate(_ coinModel: CoinModel?) {
            DispatchQueue.main.async {
                self.bitCoinLabel.text = coinModel?.lastPrice
                self.currencyLabel.text = coinModel?.currency
            }
        }

        func didFailWithError(_ error: any Error) {
            print(error)
        }
    }

