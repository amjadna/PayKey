//
//  JsonParser.swift
//  PayKey
//
//  Created by Amjad Nashshibi on 14/01/2019.
//  Copyright © 2019 Amjad Nashshibi. All rights reserved.
//

import UIKit

public class JsonParser: NSObject {

    static public func readTransactionsJSON(transactions:String) {
        
        //MARK: Parsing Transactions
        if let path = Bundle.main.path(forResource: transactions, ofType: "json") {
            do {
                let text = try String(contentsOfFile: path, encoding: .utf8)
                if let transactionsJSON = try JSONSerialization.jsonObject(with: text.data(using: .utf8)!, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String: Any]] {
                    
                    for transactionJSON in transactionsJSON {
                        if let transaction = Transaction(JSON: transactionJSON) {
                            if let doubleValue = transaction.amount?.double {
                                transaction.amountValue = doubleValue
                                DataManager.shared.appendData(transaction: transaction)
                            }
                        }
                    }
                    
                }
            }catch {
                print("File read error")
            }
        }
        
    }
    
    static public func readRatesJSON(rates:String) {
        
        //MARK: Parsing Rates
        if let path = Bundle.main.path(forResource: rates, ofType: "json") {
            do {
                let text = try String(contentsOfFile: path, encoding: .utf8)
                if let ratesJSON = try JSONSerialization.jsonObject(with: text.data(using: .utf8)!, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String: Any]] {
                    
                    for rateJSON in ratesJSON {
                        if let rate = CurrencyConversion(JSON: rateJSON) {
                            if let doubleValue = rate.rate?.double {
                                DataManager.shared.addRate(conversion: rate, value: doubleValue)
                            }
                        }
                    }
                    
                }
            }catch {
                print("File read error")
            }
        }
    }
    
}
