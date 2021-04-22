//
//  WeatherDetailViewModelTest.swift
//  WeatherInfoTests
//
//  Created by Hemant Soni on 22/04/21.
//

import XCTest
@testable import WeatherInfo

class WeatherDetailViewModelTest: XCTestCase {
    
    var weatherDetailViewModel: WeatherDetailViewModel?
    var expectation = XCTestExpectation()
    
    override func setUpWithError() throws {
        var currentSelectedWeatherData = WeatherModel()
        currentSelectedWeatherData.name = "Jodhpur"
        currentSelectedWeatherData.main.humidity = 321

        weatherDetailViewModel = WeatherDetailViewModel()
        weatherDetailViewModel?.viewModelDelegate = self
        let weatherViewModel = WeatherViewModel()
        weatherViewModel.weatherData = currentSelectedWeatherData
        weatherDetailViewModel?.currentSelectedWeatherViewModel = weatherViewModel
        
        let urlManager = URLManager()
        let url = URL(string: urlManager.getURLToFetchWeatherOfCity(city: "Jodhpur", tempUnit: TemperatureScale.getUserSavedSettingTempUnitType().rawValue))

        URLProtocolMock.testURLs = [url! : "WeatherForecastData"]
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        NetworkManager.main.setMockSession(session: session)
    }
    
    override func tearDownWithError() throws {
        weatherDetailViewModel = nil
        URLProtocolMock.clearMock()
    }
    
    func testGetCityWeather() throws {
        expectation = self.expectation(description: "Success Test")
        weatherDetailViewModel?.fetchForcastData()
        waitForExpectations(timeout: 20)
    }
    
    func testCurrentSelectedCityBasicData() {
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

// MARK: WeatherViewModelProtocol
extension WeatherDetailViewModelTest: WeatherDetailViewModelProtocol {
    func didReceiveAPISuccess() {
        XCTAssertEqual(weatherDetailViewModel?.forecastData.count, 6, "Forecast Data count Should be 6")
        let weatherInfo = weatherDetailViewModel?.itemAt(index: 1).hourlyForecast?[0]
        XCTAssertEqual(weatherDetailViewModel?.itemAt(index: 1).hourlyForecast?.count, 8, "Hourly Forecast count must be 8 for the next day forrcast")
        XCTAssertEqual(weatherInfo?.max_temp, 297.8, "Max temp must 297.8")
        XCTAssertNotEqual(weatherInfo?.min_temp, 300, "Max temp must 297.8")
        XCTAssertEqual(weatherInfo?.description, "few clouds", "description should be few clouds")
        XCTAssertEqual(weatherInfo?.time, "2021-04-24 00:00:00", "time should be 2021-04-24 00:00:00")
        XCTAssertEqual(weatherInfo?.icon, "02n", "Icon should be 02n")
        expectation.fulfill()
    }
    
    func didAPIFailWithError(_ error: WeatherInfoError) {
        print(error.rawValue)
        XCTAssertNotNil(error, "Error should not be nil if api Fail")
        expectation.fulfill()
    }
}
