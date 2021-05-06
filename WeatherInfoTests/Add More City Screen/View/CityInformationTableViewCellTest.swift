//
//  CityInformationTableViewCellTest.swift
//  WeatherInfoTests
//
//  Created by Hemant Soni on 23/04/21.
//

import XCTest
@testable import WeatherInfo

class CityInformationTableViewCellTest: XCTestCase {
    
    private var cityInformationTableViewCell: CityInformationTableViewCellTest!
    private var tableView: UITableView!
    private var cityModel = CityModel()

    private var dataSource: TableViewDataSource!
    
    override func setUp() {
        // Append some city data in cityData
        // check if user has already set the temp unit choice
        cityModel.cityName = "Jodhpur"
        cityModel.countryName = "In"
        cityModel.id = 4163971

        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 300, height: 400), style: .plain)
        tableView.register(UINib(nibName: "CityInformationTableViewCell", bundle: nil), forCellReuseIdentifier: "CityInformationTableViewCell")

        dataSource = TableViewDataSource()
        tableView.dataSource = dataSource
    }
    
    func testAwakeFromNib() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = createCell(indexPath: indexPath)
        cell.configureData(cityModel)
        
        XCTAssertNotNil(cell, "CityInformationTableViewCellT should not be nil")
        XCTAssertEqual(cell.cityNameLabel.text!, "Jodhpur, In", "cityNameLabel Label text should be Jodhpur")
    }
}

extension CityInformationTableViewCellTest {
    func createCell(indexPath: IndexPath) -> CityInformationTableViewCell {

        let cell = dataSource.tableView(tableView, cellForRowAt: indexPath) as! CityInformationTableViewCell
        XCTAssertNotNil(cell)

        let view = cell.contentView
        XCTAssertNotNil(view)

        return cell
    }
}


private class TableViewDataSource: NSObject, UITableViewDataSource {
    
    var cityData = [CityModel]()
    
    override init() {
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityInformationTableViewCell", for: indexPath)
        return cell
    }
}
