////
////  DBManagerTest.swift
////  WeatherInfoTests
////
////  Created by Hemant Soni on 20/04/21.
////
//
//import XCTest
//import RealmSwift
//@testable import WeatherInfo
//
//class DBManagerTest: XCTestCase {
//    let dbManager = DBManager()
//    private var cityName: String = ""
//    
//    override func setUpWithError() throws {
//        dbManager.deleteAll()
//        let urlManager = URLManager()
//        let url1 = URL(string: urlManager.weatherCity(cityID: "4163971"))
//        let url2 = URL(string: urlManager.weatherCity(cityID: "2147714"))
//        let url3 = URL(string: urlManager.weatherCity(cityID: "2174003"))
//        URLProtocolMock.testURLs = [url1: "weatherData",url2: "weatherData",url3: "weatherData"]
//        let config = URLSessionConfiguration.ephemeral
//        config.protocolClasses = [URLProtocolMock.self]
//        let session = URLSession(configuration: config)
//        NetworkManager.main.setMockSession(session: session)
//    }
//
//    override func tearDownWithError() throws {
//        dbManager.deleteAll()
//    }
//
//    func testIsCityInLocal() throws {
//        saveCityJSONToDB()
//        let isCityInLocal = dbManager.isCityInLocal()
//        XCTAssertTrue(isCityInLocal, "isCityInLocal should be false")
//        var cities = dbManager.getAllCity()
//        XCTAssertGreaterThan(cities.count, 0, "Cities must have some value")
//        dbManager.selectCity(city: cities.last!)
//        dbManager.deSelectCity(city: cities.last!)
//        cities = dbManager.getAllUnselectedCity()
//        XCTAssertGreaterThan(cities.count, 0, "Cities must have some value")
//        cities = dbManager.filter(city: cityName)
//        XCTAssertGreaterThan(cities.count, 0, "Cities must have some value")
//        dbManager.deleteAll()
//    }
//    
//    func testIsCityInLocalNigative() throws {
//        let isCityInLocal = dbManager.isCityInLocal()
//        XCTAssertFalse(isCityInLocal, "isCityInLocal should be false")
//    }
//    
//    func testGetAllCityNigative() throws {
//        let cities = dbManager.getAllCity()
//        XCTAssertEqual(cities.count, 0, "Cities should be empty")
//    }
//    
//    func testGetAllUnselectedCity() throws {
//        let cities = dbManager.getAllUnselectedCity()
//        XCTAssertEqual(cities.count, 0, "Cities should be empty")
//    }
//    
//    private func saveCityJSONToDB() {
//        if let path = Bundle.main.path(forResource: "city_list", ofType: "json") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                guard let users = try? JSONDecoder().decode(List<City>.self, from: data) else {
//                    return
//                }
//                guard let city = users.last else { return  }
//                cityName = city.name ?? ""
//                users.removeAll()
//                users.append(city)
//                dbManager.saveCity(city: users)
//              } catch {
//                print(error.localizedDescription)
//              }
//        }
//    }
//
//}
//
