//
//  Constants.swift
//  PayKey
//
//  Created by Amjad Nashshibi on 14/01/2019.
//  Copyright © 2019 Amjad Nashshibi. All rights reserved.
//

import Foundation

//MARK: Json Files
let kTransactionsJSON = "transactions1"
let kRatesJSON = "rates1"

//MARK: Cell Identifiers
let kProductCell = "ProductCell"
let kTransactionCell = "TransactionCell"

//MARK: Headers Identifiers
let kProductsHeader = "ProductsHeader"

//MARK: desiredCurrency
let desiredCurrency = "GBP"

//MARK: Segue Identifiers
let kProductSegue = "ProductSegue"

//MARK: GCD Identifiers
let concurrentProductsQueue =
    DispatchQueue(
        label: "com.amjad.productsQueue",
        attributes: .concurrent)

let concurrentRatesQueue =
    DispatchQueue(
        label: "com.amjad.ratesQueue",
        attributes: .concurrent)
