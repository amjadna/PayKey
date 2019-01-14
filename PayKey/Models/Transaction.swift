//
//  Transaction.swift
//  PayKey
//
//  Created by Amjad Nashshibi on 14/01/2019.
//  Copyright © 2019 Amjad Nashshibi. All rights reserved.
//

import Foundation
import ObjectMapper

/*
 {
 "amount":"1",
 "currency":"GBP",
 "sku":"J4064"
 }
 */

class Transaction: Mappable, CustomStringConvertible {
    var amount: String?
    var currency: String?
    var sku:String?
    var amountValue: Double = 0
    
    var description: String {
        var result = "amount: \(String(describing: amount))\n"
        result += "currency: \(String(describing: currency))\n"
        result += "sku: \(String(describing: sku))\n"
        return result
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        amount <- map["amount"]
        currency <- map["currency"]
        sku <- map["sku"]
    }
}

