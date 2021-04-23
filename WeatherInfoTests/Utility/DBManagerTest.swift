//
//  DBManagerTest.swift
//  WeatherInfoTests
//
//  Created by Hemant Soni on 20/04/21.
//

import XCTest
import RealmSwift
@testable import WeatherInfo

class DBManagerTest: XCTestCase {
    let dbManager = DBManager()
    private var cityName: String = ""
    
    override func setUpWithError() throws {
        dbManager.deleteAll()
    }

    override func tearDownWithError() throws {
        dbManager.deleteAll()
    }
    
    func testAllSelectedCityDataPositive() {
        // remove all city data and check the city data count in DB
        dbManager.deleteAll()
        // save city into local
        self.saveCityListJSONToDB()
        // Check as per requirement three default city will always be selected (Visible)
        let totalCitiesStored = dbManager.fetchAllSelectedCities().count
        XCTAssertGreaterThan(totalCitiesStored, 0, "totalCitiesStored must have some value")
    }
    

    func testIsCityDataStoredInLocalDBPositive() {
        self.saveCityListJSONToDB()
        // Check city data is stored in realm DB
        let isCityDataSaved = dbManager.checkIsAllCitiesDataAlreadySaved()
        XCTAssertTrue(isCityDataSaved, "isCityDataSaved should be true")
    }
    
    func testIsCityDataStoredInLocalDBNegative() {
        // remove all city data and check the city data count in DB
        dbManager.deleteAll()
        // Check city data is stored in realm DB
        let isCityDataSaved = dbManager.checkIsAllCitiesDataAlreadySaved()
        XCTAssertFalse(isCityDataSaved, "isCityDataSaved should be false")
    }
    
    // Save city data in local DB
    private func saveCityListJSONToDB() {
        if let path = Bundle.main.path(forResource: "cityList", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                guard let cityData = try? JSONDecoder().decode(List<CityModel>.self, from: data) else {
                    return
                }
                guard let city = cityData.last else { return  }
                // set this city to visible bydefault
                self.dbManager.updateVisibilityStatus(city, true)
//                city.isVisible = true
                cityData.removeAll()
                cityData.append(city)
                dbManager.saveCity(city: cityData)
              } catch {
                print(error.localizedDescription)
              }
        }
    }
}

