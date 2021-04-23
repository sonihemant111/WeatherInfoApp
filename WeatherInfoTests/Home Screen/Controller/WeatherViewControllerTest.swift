//
//  WeatherViewControllerTest.swift
//  WeatherInfoTests
//
//  Created by Hemant Soni on 22/04/21.

import XCTest
@testable import WeatherInfo

class WeatherListViewControllerTest: XCTestCase {
    private var storyboard: UIStoryboard!
    private var sut: WeatherListTableViewController!
    private var weatherListViewModel: WeatherListViewModel!
    
    override func setUp() {
        storyboard = UIStoryboard(name: "WeatherInfo", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "WeatherListTableViewController") as? WeatherListTableViewController
        sut.loadViewIfNeeded()
        weatherListViewModel = sut.weatherListViewModel
    }
    
    override func tearDown() {
        storyboard = nil
        sut = nil
        weatherListViewModel = nil
    }
    
    func testPullToRefresh() {
        sut.refreshWeatherData()
    }
    
    func testCheckInternetConnection() {
        sut.checkInternetConnection()
    }
    
    func testRedirectUserToSettingScreen() {
        sut.redirectToSettingsScreen()
    }
    
    func testRedirectUserToAddMoreCityScreen() {
        sut.redirectToAddMoreCityScreen()
    }
    
    func testShowAlert() {
        sut.showToast("Testing")
    }
    
    func testThatViewLoads() {
        XCTAssertNotNil(sut.view, "View not initiated properly")
    }
    
    func testParentViewHasTableViewSubview() {
        XCTAssertTrue(self.sut.view.contains(self.sut.tableView), "View does not have a table subview")
    }    
    
    func testThatTableViewLoads() {
        XCTAssertNotNil(self.sut.tableView, "TableView is not connected to an IBOutlet")
    }
    
}

//Mark: UITableView tests
extension WeatherListViewControllerTest {
    func testThatViewConformsToUITableViewDataDelegate() {
        XCTAssertTrue(self.sut.conforms(to: UITableViewDelegate.self), "View does not conform to UITableView delegate protocol")
    }
    
    func testThatViewConformsToUITableViewDataSource() {
        XCTAssertTrue(self.sut.conforms(to: UITableViewDataSource.self), "View does not conform to UITableView datasource protocol")
    }
    
    func testTableViewIsConnectedToDelegate() {
        XCTAssertNotNil(self.sut.tableView.delegate, "TableView delegate cannot be nil")
    }

    func testTableViewIsConnectedToDataSource() {
        XCTAssertNotNil(self.sut.tableView.dataSource, "TableView datasource cannot be nil")
    }
    
    func testTableViewNumberOfRowsInSection() {
        XCTAssertTrue(self.sut.tableView.numberOfSections == 1, "TableView must have 1 section")
    }
    
    func test_cellForRow_populatesCell() {
        if weatherListViewModel.weatherViewModels.count == 0 {
            let weatherViewModel = WeatherViewModel()
            weatherViewModel.weatherData.cityID = 1234
            weatherViewModel.weatherData.name = "Jodhpur"
            weatherListViewModel.weatherViewModels.append(weatherViewModel)
        }
        
        let weatherViewModel = self.weatherListViewModel.weatherViewModels[0]
        weatherViewModel.weatherData.name = "Jodhpur"
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = self.sut.tableView.dataSource?.tableView(self.sut.tableView, cellForRowAt: indexPath) as! WeatherInformationTableViewCell
        XCTAssertEqual(cell.cityNameLabel.text, "Jodhpur", "City name text should be Jodhpur")
    }
}
