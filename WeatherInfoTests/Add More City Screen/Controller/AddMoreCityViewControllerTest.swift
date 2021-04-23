//
//  AddMoreCityViewControllerTest.swift
//  WeatherInfoTests
//
//  Created by Hemant Soni on 23/04/21.
//

import XCTest
@testable import WeatherInfo

class AddMoreCityViewControllerTest: XCTestCase {
    var storyboard: UIStoryboard!
    var sut: AddMoreCityViewController!
    var viewModel: AddMoreCityViewModel?
    
    override func setUp() {
        storyboard = UIStoryboard(name: "WeatherInfo", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "AddMoreCityViewController") as? AddMoreCityViewController
        sut.loadViewIfNeeded()
        viewModel = sut.viewModel
    }
    
    override func tearDown() {
        storyboard = nil
        sut = nil
        viewModel = nil
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
extension AddMoreCityViewControllerTest {
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
