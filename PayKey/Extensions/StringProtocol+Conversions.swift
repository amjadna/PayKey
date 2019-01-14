//
//  StringProtocol+Conversions.swift
//  PayKey
//
//  Created by Amjad Nashshibi on 14/01/2019.
//  Copyright © 2019 Amjad Nashshibi. All rights reserved.
//

import Foundation

extension StringProtocol {
    var double: Double? {
        return Double(self)
    }
    var float: Float? {
        return Float(self)
    }
    var integer: Int? {
        return Int(self)
    }
}
