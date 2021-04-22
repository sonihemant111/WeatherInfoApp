//
//  WeatherInformationTableViewCellTest.swift
//  WeatherInfoTests
//
//  Created by Hemant Soni on 22/04/21.
//

import XCTest
@testable import WeatherInfo

class WeatherInformationTableViewCellTest: XCTestCase {
    
    var WeatherInformationTableViewCell: WeatherInformationTableViewCell!
    var tableView: UITableView!
    var cityData = [WeatherViewModel]()
    
    override func setUp() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 300, height: 400), style: .plain)
        tableView.register(UINib(nibName: "WeatherInformationTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherInformationTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        // Append some city data in cityData
        let weatherViewModel = WeatherViewModel()
        weatherViewModel.weatherData.name = "Jodhpur"
        weatherViewModel.weatherData.main.temp = 311.90
        cityData.append(weatherViewModel)
    }
    
    func testAwakeFromNib() {
        self.tableView.reloadData()
    }
}

extension WeatherInformationTableViewCellTest: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherInformationTableViewCell", for: indexPath) as! WeatherInformationTableViewCell
        XCTAssertNotNil(cell, "WeatherInformationTableViewCell should not be nil")
        XCTAssertNotNil(cell.cityNameLabel, "cityNameLabel should not be nil")
        XCTAssertNotNil(cell.refreshButton, "refreshButton should not be nil")

        cell.configureCell(cityData[indexPath.row])
        return cell
    }
}
