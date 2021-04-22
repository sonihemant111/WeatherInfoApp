//
//  AddMoreCityViewModelTest.swift
//  WeatherInfoTests
//
//  Created by Hemant Soni on 22/04/21.
//

import XCTest
import RealmSwift
@testable import WeatherInfo

class AddMoreCityViewModelTest: XCTestCase {
    
    var addMoreViewModel: AddMoreCityViewModel?
    var expectationToFetchCityData = XCTestExpectation()
    var cityName = "Gerton"
    
    override func setUpWithError() throws {
        addMoreViewModel = AddMoreCityViewModel()
        addMoreViewModel?.delegate = self
        addMoreViewModel?.dbManager.deleteAll()
    }
    
    override func tearDownWithError() throws {
        addMoreViewModel = nil
    }
    
    func getSearchCity() {
        expectationToFetchCityData = self.expectation(description: "Success Test")
        addMoreViewModel?.fetchSearchedCity(cityName)
        waitForExpectations(timeout: 20)
    }
    
    func numberOfSearchResult() {
        self.addMoreViewModel?.addMoreCityViewModels.removeAll()
        XCTAssertEqual(self.addMoreViewModel?.numberOfRow, 0, "Number of search result must be equal to 0 ")
    }
    
    // Save city data in local DB
    func testSaveCityListJSONToDB() {
        if let path = Bundle.main.path(forResource: "cityList", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                guard let cityData = try? JSONDecoder().decode(List<CityModel>.self, from: data) else {
                    return
                }
                guard let city = cityData.last else { return  }
                // set this city to visible bydefault
                city.isVisible = false
                cityData.removeAll()
                cityData.append(city)
                self.addMoreViewModel?.dbManager.saveCity(city: cityData)
                
                self.getSearchCity()
              } catch {
                print(error.localizedDescription)
              }
        }
    }
}

extension AddMoreCityViewModelTest: AddMoreCityViewModelProtocol {
    func fetchedDataSuccessfully() {
        if let numberOfSearchResult = addMoreViewModel?.numberOfRow {
            XCTAssertEqual(numberOfSearchResult, 1, "Number of count of Gerton city in database must be 1")
        }
        expectationToFetchCityData.fulfill()
    }
}
