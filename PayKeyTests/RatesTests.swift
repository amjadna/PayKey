//
//  RatesTests.swift
//  PayKeyTests
//
//  Created by Amjad Nashshibi on 14/01/2019.
//  Copyright © 2019 Amjad Nashshibi. All rights reserved.
//

import XCTest
@testable import PayKey

class RatesTests: XCTestCase {

    var rateUSDtoGBP = 0.0
    var rateEURtoGBP = 0.0
    var rateAUDtoGBP = 0.0
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let USDtoGBP = CurrencyConversion(to: "GBP", from: "USD", rate: "0.5")
        let EURtoUSD = CurrencyConversion(to: "USD", from: "EUR", rate: "0.25")
        let AUDtoUSD = CurrencyConversion(to: "USD", from: "AUD", rate: "0.75")
        
        DataManager.shared.populateMissingConversionsToDesiredCurrency()
        
        rateUSDtoGBP = USDtoGBP.rate?.double ?? -1
        rateEURtoGBP = (EURtoUSD.rate?.double ?? -1) * rateUSDtoGBP
        rateAUDtoGBP = (AUDtoUSD.rate?.double ?? -1) * rateUSDtoGBP
        
        DataManager.shared.deleteRates()
        
        DataManager.shared.addRate(conversion: USDtoGBP, value: USDtoGBP.rate?.double ?? 0.0)
        DataManager.shared.addRate(conversion: EURtoUSD, value: EURtoUSD.rate?.double ?? 0.0)
        DataManager.shared.addRate(conversion: AUDtoUSD, value: AUDtoUSD.rate?.double ?? 0.0)
        
        
        DataManager.shared.populateMissingConversionsToDesiredCurrency()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testDoubleConversion() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(DataManager.shared.rates[CurrencyConversion(to: "GBP", from: "USD")], 0.5, "Column count setup failed")
        XCTAssertEqual(DataManager.shared.rates[CurrencyConversion(to: "USD", from: "EUR")], 0.25, "Column count setup failed")
        XCTAssertEqual(DataManager.shared.rates[CurrencyConversion(to: "USD", from: "AUD")], 0.75, "Column count setup failed")
    }
    
    func testPopulateConversionValues() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssertEqual(DataManager.shared.rates[CurrencyConversion(to: "GBP", from: "USD")]!, rateUSDtoGBP, "Column count setup failed")
        XCTAssertEqual(DataManager.shared.rates[CurrencyConversion(to: "GBP", from: "EUR")]!, rateEURtoGBP, "Column count setup failed")
        XCTAssertEqual(DataManager.shared.rates[CurrencyConversion(to: "GBP", from: "AUD")]!, rateAUDtoGBP, "Column count setup failed")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
