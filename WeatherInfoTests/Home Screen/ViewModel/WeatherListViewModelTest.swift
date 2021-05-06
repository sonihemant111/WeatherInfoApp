//
//  WeatherInfoTests.swift
//  WeatherInfoTests
//
//  Created by Hemant Soni on 13/04/21.
//

import XCTest
@testable import WeatherInfo

class WeatherListViewModelTest: XCTestCase {

    private var weatherListViewModel: WeatherListViewModel?
    private var expectation = XCTestExpectation()
    private var weatherViewModels = [WeatherViewModel]()
    
    override func setUpWithError() throws {
        weatherListViewModel = WeatherListViewModel()
        
        let urlManager = URLManager()

        
        // prepare weatherViewModel
        for i in 0...1 {
            let weatherViewModel = WeatherViewModel()
            var weatherData = WeatherModel()
            weatherData.cityID = 4163971
            if i == 1 {
                weatherData.name = "Jodhpur"
                let url = URL(string: urlManager.getURLToFetchWeatherOfCity(city: "Jodhpur", tempUnit: TemperatureScale.getUserSavedSettingTempUnitType().rawValue))
                URLProtocolMock.testURLs[url!] = "WeatherData"
            } else {
                weatherData.name = "Jaipur12345"
                let url = URL(string: urlManager.getURLToFetchWeatherOfCity(city: "Jaipur", tempUnit: TemperatureScale.getUserSavedSettingTempUnitType().rawValue))
                URLProtocolMock.testURLs[url!] = "WeatherData"
            }
            weatherViewModel.weatherData = weatherData
            weatherViewModel.indexPath = IndexPath(row: i, section: 0)
            weatherViewModel.delegate = self
            weatherViewModels.append(weatherViewModel)
        }
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        NetworkManager.main.setMockSession(session: session)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        weatherListViewModel = nil
        URLProtocolMock.clearMock()
    }
    
    func testGetCityWeatherPositive() throws {
        let weatherViewModel = self.weatherViewModels[0]
        expectation = self.expectation(description: "Success Test")
        weatherViewModel.getWeatherData()
        waitForExpectations(timeout: 20)
    }
    
    func testGetCityWeatherNegative() throws {
        let weatherViewModel = self.weatherViewModels[1]
        expectation = self.expectation(description: "Success Test")
        weatherViewModel.getWeatherData()
        waitForExpectations(timeout: 20)
    }
}

// MARK: WeatherViewModelProtocol
extension WeatherListViewModelTest: WeatherViewModelProtocol {
    func didFailWithError(_ indexPath: IndexPath, _ error: WeatherInfoError) {
        print(error.rawValue)
        expectation.fulfill()
    }
    
    func didReceiveTemperatureData(_ indexPath: IndexPath) {
        let weatherViewModel = self.weatherViewModels[indexPath.row]
        XCTAssertNotEqual(weatherViewModel.temperature, "", "temperature should not be empty")
        XCTAssertEqual(weatherViewModel.cityName, "Jodhpur", "city name should be Jodhpur")
        XCTAssertEqual(weatherViewModel.weatherData.sys.country, "IN", "Country name must be IN")
        XCTAssertEqual(weatherViewModel.cityID, 4163971,"city ID must be 4163971")
        expectation.fulfill()
    }
}
