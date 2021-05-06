//
//  WeatherInfoUITests.swift
//  WeatherInfoUITests
//
//  Created by Hemant Soni on 13/04/21.
//

import XCTest

class WeatherInfoUITests: XCTestCase {
    
    var app: XCUIApplication!
    // App's Table View
    var weatherListTableView: XCUIElement!
    var settingsTableView: XCUIElement!
    var addMoreCityTableView: XCUIElement!
    
    // Nav Bar button on Home Screen
    var settingNavBarButton: XCUIElement!
    var addMoreCityNavBarButton: XCUIElement!
    
    // App's Table View Cell
    var weatherListTableViewCell: XCUIElementQuery!
    var addMoreCityTableViewCell: XCUIElementQuery!
    var settingsTableViewCells: XCUIElementQuery!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
        // Nav Bar Button
        settingNavBarButton = app.buttons["settingButton"]
        addMoreCityNavBarButton = app.buttons["addButton"]
    }

    override func tearDownWithError() throws {
        app = nil
        weatherListTableView = nil
        settingsTableView = nil
        addMoreCityTableView = nil

        settingNavBarButton = nil
        addMoreCityNavBarButton = nil
        
        settingsTableViewCells = nil
        weatherListTableViewCell = nil
        addMoreCityTableViewCell = nil
        
        try super.tearDownWithError()
    }
    
    func testWeatherInfo_WeatherListHomeScreen() {
        // Initialize XCUIElement
        weatherListTableView = app.tables["WeatherListTableView"]
        weatherListTableViewCell = weatherListTableView.cells
        
        XCTAssertTrue(weatherListTableView.isEnabled, "")
        XCTAssertTrue(settingNavBarButton.isEnabled, "")
        XCTAssertTrue(addMoreCityNavBarButton.isEnabled, "")
    }
    
    func testWeatherInfo_SettingScreen_ChooseTempUnit() {
        // Go to settings screen
        settingNavBarButton.tap()
        // select fahrenheit
        settingsTableView = app.tables["settingsTable"]
        XCTAssertTrue(settingsTableView.isEnabled, "")
        settingsTableViewCells = settingsTableView.cells
        settingsTableViewCells.element(boundBy: 1).tap()
    }
        
    func testWeatherInfo_AddMoreCityScreen_SearchByCityName_AddNewCity() {
        // Go to add city
        addMoreCityNavBarButton.tap()
    }
}
