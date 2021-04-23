//
//  WeatherAPITest.swift
//  WeatherInfoTests
//
//  Created by Hemant Soni on 22/04/21.
//

import Foundation

import XCTest
@testable import WeatherInfo

class WeatherAPITest: XCTestCase {
    private var weatherAPI = WeatherAPI.shared
    private var cityName = "Jodhpur"
    private var expectationForWeatherData = XCTestExpectation()
    private var expectationForForecastData = XCTestExpectation()
    
    func testGetWeatherOfCity() {
        expectationForWeatherData = self.expectation(description: "Success Test")
        
        weatherAPI.fetchCurrentWeather(cityName: cityName, tempScale: .fahrenheit) { [weak self] (weatherData, error) in
            guard let `self` = self, let jodhpurWeatherData = weatherData  else {
                XCTAssertTrue(false, "Got an error")
                return
            }
            if error == nil {
                XCTAssertEqual(jodhpurWeatherData.name, self.cityName, "City Name should be Jodhpur")
                
            }
            self.expectationForWeatherData.fulfill()
        }
        waitForExpectations(timeout: 20)
    }
    
    func testForecastDataOfCity() {
        expectationForForecastData = self.expectation(description: "Success Test")
        
        weatherAPI.fetchNextFiveWeatherForecast(city: cityName) { [weak self] (forecastData, error) in
            guard let `self` = self, let jodhpurWeatherForecastData = forecastData  else {
                XCTAssertTrue(false, "Got an error")
                return
            }
            print(jodhpurWeatherForecastData)
            self.expectationForForecastData.fulfill()
        }
        waitForExpectations(timeout: 10)
    }
}
