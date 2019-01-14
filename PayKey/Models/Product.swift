//
//  Product.swift
//  PayKey
//
//  Created by Amjad Nashshibi on 14/01/2019.
//  Copyright © 2019 Amjad Nashshibi. All rights reserved.
//

import UIKit

class Product {
    
    let sku:String
    var transactionsCount:Int
    
    var transactions: [String: [Transaction]]

    init(sku:String) {
        self.sku = sku
        self.transactionsCount = 0
        self.transactions = [:]
    }
    
    func addTransaction(transaction:Transaction) {
        
        //Update transactions Amount
        
        if let currency = transaction.currency {
            var trans:[Transaction] = self.transactions[currency] ?? []
            trans.append(transaction)
            transactions[currency] = trans
            transactionsCount += 1
        }
    }

}
