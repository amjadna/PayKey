//
//  CurrencyConversion.swift
//  PayKey
//
//  Created by Amjad Nashshibi on 14/01/2019.
//  Copyright © 2019 Amjad Nashshibi. All rights reserved.
//

import UIKit
import ObjectMapper

class CurrencyConversion:Hashable,Mappable, CustomStringConvertible {
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    init(to:String, from:String, rate:String = "") {
        self.to = to
        self.from = from
        self.rate = rate
    }
    
    var to: String?
    var from: String?
    var rate:String?
    
    func mapping(map: Map) {
        to <- map["to"]
        from <- map["from"]
        rate <- map["rate"]
    }
    
    var description: String {
        var result = "to: \(String(describing: to))\n"
        result += "from: \(String(describing: from))\n"
        result += "rate: \(String(describing: rate))\n"
        return result
    }
    
    static func == (lhs: CurrencyConversion, rhs: CurrencyConversion) -> Bool {
        return ((lhs.to == rhs.to) && (lhs.from == rhs.from))
    }
    
    var hashValue: Int { return "\(to ?? "0")\(from ?? "0")".hashValue }
    
}



