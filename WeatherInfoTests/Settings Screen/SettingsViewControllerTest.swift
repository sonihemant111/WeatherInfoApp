//
//  SettingsViewControllerTest.swift
//  WeatherInfoTests
//
//  Created by Hemant Soni on 22/04/21.
//

import XCTest
@testable import WeatherInfo

class SettingsViewControllerTest: XCTestCase {
    var storyboard: UIStoryboard!
    var sut: SettingsViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard(name: "WeatherInfo", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        storyboard = nil
        sut = nil
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
extension SettingsViewControllerTest {
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
}
