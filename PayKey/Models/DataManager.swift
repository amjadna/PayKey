//
//  DataManager.swift
//  PayKey
//
//  Created by Amjad Nashshibi on 14/01/2019.
//  Copyright © 2019 Amjad Nashshibi. All rights reserved.
//

import UIKit

class DataManager{
    
    //MARK: Singletone
    static let shared = DataManager()
    
    //MARK: Products Managing
    private var unsafeProducts: [String: Product] = [:]
    
    var products: [String: Product] {
        var productsCopy: [String: Product]!
        concurrentProductsQueue.sync {
            productsCopy = self.unsafeProducts
        }
        return productsCopy
    }
    
    func appendData(transaction:Transaction) {
        if let sku = transaction.sku {
            concurrentProductsQueue.async(flags: .barrier) { [weak self] in
                guard let self = self else {
                    return
                }
                var product:Product
                product = self.unsafeProducts[sku] ?? Product(sku: sku)
                product.addTransaction(transaction: transaction)
                self.unsafeProducts[sku] = product
            }
        }
    }
    
    //MARK: Rates Managing
    private var unsafeRates:[CurrencyConversion : Double] = [:]
    
    var rates: [CurrencyConversion : Double] {
        var ratesCopy: [CurrencyConversion : Double]!
        concurrentRatesQueue.sync {
            ratesCopy = self.unsafeRates
        }
        return ratesCopy
    }
    
    func deleteRates() {
        concurrentRatesQueue.sync {
            self.unsafeRates = [:]
        }
    }
    
    func addRate(conversion:CurrencyConversion, value:Double) {
        
        if rates[conversion] == nil {
            concurrentRatesQueue.async(flags: .barrier) { [weak self] in
                guard let self = self else {
                    return
                }
                self.unsafeRates[conversion] = value
            }
        }
    }
    
    func getConversionValue(to:String, from:String) -> Double {
        
        if (to == from) {
            return 1.0
        }
        else if let multiplier = DataManager.shared.rates[CurrencyConversion(to: to, from: from, rate: "0.0")] {
            return multiplier
        }
        else {
            return 0.0
        }

    }
    
    /*
     * Populating missing rates are done by searching destination desired currency and backtracking to other missing rates
     * i.e if I have USD to AUD and EUR to AUD and AUD to GBP then I can get USD to GBP and EUR to GBP by backtracking from
     * AUD-GBP -> USD-AUD which Means multipling USD-AUD * AUD-GBP so I get eventualy USDtoGBP rate
    */
    
    func populateMissingConversionsToDesiredCurrency() {
        DataManager.shared.populate(populateRates: DataManager.shared.rates,main: desiredCurrency,to: desiredCurrency, multiplier: 1.0)
    }
    
    func populate(populateRates: [CurrencyConversion : Double], main:String, to:String, multiplier:Double) {
        for rate in populateRates {
            if (rate.key.to! == to)
            {
                addRate(conversion: CurrencyConversion(to: main, from: rate.key.from!, rate: "\(multiplier * rate.value)"), value: multiplier * rate.value)
                var newRates = populateRates
                newRates.removeValue(forKey: rate.key)
                populate(populateRates: newRates, main: main,to: rate.key.from!, multiplier: multiplier * rate.value)
            }
        }
    }
    
}

