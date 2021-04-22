//
//  WeatherInfoTests.swift
//  WeatherInfoTests
//
//  Created by Hemant Soni on 13/04/21.
//

import XCTest
@testable import WeatherInfo

class WeatherInfoTests: XCTestCase {

    var weatherListViewModel: WeatherListViewModel?
    var expectation = XCTestExpectation()
    
    override func setUpWithError() throws {
        weatherListViewModel = WeatherListViewModel()
        
        let urlManager = URLManager()
        let url = URL(string: urlManager.getURLToFetchWeatherOfCity(city: "Jodhpur", tempUnit: TemperatureScale.getUserSavedSettingTempUnitType().rawValue))

        URLProtocolMock.testURLs = [url! : "WeatherData"]
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
    
    func testGetCityWeather() throws {
        // prepare weatherViewModel
        let weatherViewModel = WeatherViewModel()
        var weatherData = WeatherModel()
        weatherData.cityID = 4163971
        weatherData.name = "Jodhpur"
        weatherViewModel.weatherData = weatherData
        weatherViewModel.indexPath = IndexPath(row: 0, section: 0)
        weatherViewModel.delegate = self
        weatherListViewModel?.weatherViewModels.append(weatherViewModel)

        expectation = self.expectation(description: "Success Test")
        weatherViewModel.getWeatherData()
        waitForExpectations(timeout: 50)
    }

}

// MARK: WeatherViewModelProtocol
extension WeatherInfoTests: WeatherViewModelProtocol {
    func didFailWithError(_ indexPath: IndexPath, _ error: WeatherInfoError) {
        print(error.rawValue)
        expectation.fulfill()
    }
    
    func didReceiveTemperatureData(_ indexPath: IndexPath) {
        let weatherViewModel = weatherListViewModel?.weatherViewModels[indexPath.row]
        XCTAssertNotEqual(weatherViewModel?.temperature, "", "temperature should not be empty")
        XCTAssertEqual(weatherViewModel?.cityName, "Jodhpur", "city name should be Jodhpur")
        XCTAssertEqual(weatherViewModel?.weatherData.sys.country, "IN", "Country name must be IN")
        XCTAssertEqual(weatherViewModel?.cityID, 4163971,"city ID must be 4163971")
        expectation.fulfill()
    }
}
