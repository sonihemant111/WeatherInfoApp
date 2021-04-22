//
//  DoubleExtensionTest.swift
//  WeatherInfoTests
//
//  Created by Hemant Soni on 22/04/21.

import XCTest
@testable import WeatherInfo

class DoubleExtensionTest: XCTestCase {
    func testTruncate() {
        let temperature = 102.3456
        XCTAssertEqual(temperature.truncate(places: 2), 102.34, "temperature should be 102.34")
    }
    
    func testkelvinToCeliusConverter() {
        let temperature = 311.15
        print(temperature.kelvinToCeliusConverter())
        XCTAssertEqual(temperature.kelvinToCeliusConverter(), 38.0, "temperature should be 38.0 in celsius")
    }
    
    func testkelvinToFahrenheitConverter() {
        let temperature = 311.15
        XCTAssertEqual(temperature.kelvinToFahrenheitConverter(), 100.4, "temperature should be 100.4 in Fahrenheit")
    }
}


