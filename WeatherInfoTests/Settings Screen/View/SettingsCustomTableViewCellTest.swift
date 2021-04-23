//
//  SettingsCustomTableViewCellTest.swift
//  WeatherInfoTests
//
//  Created by Hemant Soni on 23/04/21.
//

import XCTest
@testable import WeatherInfo

class SettingsCustomTableViewCellTest: XCTestCase {
    
    private var settingsCustomTableViewCell: SettingsCustomTableViewCell!
    private var tableView: UITableView!
    private var settingModel = SettingsModel()

    private var dataSource: TableViewDataSource!
    
    override func setUp() {
        // Append some city data in cityData
        // check if user has already set the temp unit choice
        settingModel.isSelected = false
        settingModel.tempUnit = StringConstants.fahrenheit

        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 300, height: 400), style: .plain)
        tableView.register(UINib(nibName: "SettingsCustomTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsCustomTableViewCell")

        dataSource = TableViewDataSource()
        tableView.dataSource = dataSource
    }
    
    func testAwakeFromNib() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = createCell(indexPath: indexPath)
        cell.configureData(settingModel)
        
        XCTAssertEqual(cell.temperatureUnitLabel.text, StringConstants.fahrenheit, "temperatureUnit Label text should be fahrenheit")
        XCTAssertNotNil(cell, "SettingsCustomTableViewCell should not be nil")
        XCTAssertNotNil(cell.temperatureUnitLabel, "temperatureUnitLabel should not be nil")
        XCTAssertNotNil(cell.checkUncheckImage, "checkUncheckImage should not be nil")
    }
}

extension SettingsCustomTableViewCellTest {
    func createCell(indexPath: IndexPath) -> SettingsCustomTableViewCell {

        let cell = dataSource.tableView(tableView, cellForRowAt: indexPath) as! SettingsCustomTableViewCell
        XCTAssertNotNil(cell)

        let view = cell.contentView
        XCTAssertNotNil(view)

        return cell
    }
}


private class TableViewDataSource: NSObject, UITableViewDataSource {
    
    var settingsData = [SettingsModel]()
    
    override init() {
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCustomTableViewCell", for: indexPath)
        return cell
    }
}
