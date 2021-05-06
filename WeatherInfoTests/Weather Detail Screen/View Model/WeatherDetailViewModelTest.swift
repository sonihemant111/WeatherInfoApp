//
//  WeatherDetailViewModelTest.swift
//  WeatherInfoTests
//
//  Created by Hemant Soni on 22/04/21.
//

import XCTest
@testable import WeatherInfo

class WeatherDetailViewModelTest: XCTestCase {
    
    private var weatherDetailViewModel: WeatherDetailViewModel?
    private var expectation = XCTestExpectation()
    
    override func setUpWithError() throws {
        var currentSelectedWeatherData = WeatherModel()
        currentSelectedWeatherData.name = "Jodhpur"
        currentSelectedWeatherData.cityID = 4163971
        currentSelectedWeatherData.main.humidity = 321
        
        weatherDetailViewModel = WeatherDetailViewModel()
        weatherDetailViewModel?.viewModelDelegate = self
        let weatherViewModel = WeatherViewModel()
        weatherViewModel.weatherData = currentSelectedWeatherData
        weatherDetailViewModel?.currentSelectedWeatherViewModel = weatherViewModel
    }
    
    override func tearDownWithError() throws {
        weatherDetailViewModel = nil
    }
    
    func testCurrentSelectedCityWeatherData() {
        XCTAssertEqual(weatherDetailViewModel?.currentSelectedCityName, "Jodhpur", "Current selected city name should be Jodhpur")
        if let settingsModel = UserDefaults.standard.getUserSavedSettings() {
            if settingsModel.tempUnit == "Celsius" {
                XCTAssertEqual(weatherDetailViewModel?.currentSelectedCityHumidity, "321.0℃", "Current selected city name should be Jodhpur")
            } else {
                XCTAssertEqual(weatherDetailViewModel?.currentSelectedCityHumidity, "321.0℉", "Current selected city name should be Jodhpur")
            }
        }
    }
}

//MARK: WeatherViewModelProtocol
extension WeatherDetailViewModelTest: WeatherDetailViewModelProtocol {
    func didReceiveAPISuccess() {
        XCTAssertEqual(weatherDetailViewModel?.forecastData.count, 6, "Forecast Data count Should be 6")
        let weatherInfo = weatherDetailViewModel?.itemAt(index: 0).hourlyForecast?[0]
        XCTAssertEqual(weatherDetailViewModel?.itemAt(index: 1).hourlyForecast?.count, 8, "Hourly Forecast count must be 8 for the next day forrcast")
        XCTAssertGreaterThan(Int(weatherInfo?.description.count ?? 0), 0, "description should not be empty")
        XCTAssertGreaterThan(Int(weatherInfo?.icon.count ?? 0), 0, "description should not be empty")
        XCTAssertGreaterThan(Int(weatherInfo?.time.count ?? 0), 0, "time should not be empty")
        expectation.fulfill()
    }

    func didAPIFailWithError(_ error: WeatherInfoError) {
        print(error.rawValue)
        XCTAssertNotNil(error, "Error should not be nil if api Fail")
        expectation.fulfill()
    }
}
