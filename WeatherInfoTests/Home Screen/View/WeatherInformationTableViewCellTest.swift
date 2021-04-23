//
//  WeatherInformationTableViewCellTest.swift
//  WeatherInfoTests
//
//  Created by Hemant Soni on 22/04/21.
//

import XCTest
@testable import WeatherInfo

class WeatherInformationTableViewCellTest: XCTestCase {
    
    private var weatherInformationTableViewCell: WeatherInformationTableViewCell!
    private var tableView: UITableView!
    private let weatherViewModel = WeatherViewModel()
    private var dataSource: TableViewDataSource!
    
    override func setUp() {
        // Append some city data in cityData
        weatherViewModel.weatherData.name = "Jodhpur"
        weatherViewModel.weatherData.main.temp = 311.90

        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 300, height: 400), style: .plain)
        tableView.register(UINib(nibName: "WeatherInformationTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherInformationTableViewCell")

        dataSource = TableViewDataSource()
        tableView.dataSource = dataSource
    }
    
    func testAwakeFromNib() throws {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = createCell(indexPath: indexPath)
        cell.configureCell(weatherViewModel)
        XCTAssertNotNil(cell, "WeatherInformationTableViewCell should not be nil")
        XCTAssertNotNil(cell.cityNameLabel, "cityNameLabel should not be nil")
        XCTAssertNotNil(cell.refreshButton, "refreshButton should not be nil")
        XCTAssertEqual(cell.cityNameLabel.text, "Jodhpur", "City Label text should be Jodhpur")
    }
}

extension WeatherInformationTableViewCellTest {
    func createCell(indexPath: IndexPath) -> WeatherInformationTableViewCell {

        let cell = dataSource.tableView(tableView, cellForRowAt: indexPath) as! WeatherInformationTableViewCell
        XCTAssertNotNil(cell)

        let view = cell.contentView
        XCTAssertNotNil(view)

        return cell
    }
}


private class TableViewDataSource: NSObject, UITableViewDataSource {
    
    var cityData = [WeatherViewModel]()
    
    override init() {
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherInformationTableViewCell", for: indexPath)
        return cell
    }
}
