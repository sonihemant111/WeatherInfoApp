//
//  WeatherDetailViewControllerTest.swift
//  WeatherInfoTests
//
//  Created by Hemant Soni on 22/04/21.
//

import XCTest
@testable import WeatherInfo

class WeatherDetailViewControllerTest: XCTestCase {
    var storyboard: UIStoryboard!
    var sut: WeatherDetailViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard(name: "WeatherInfo", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "WeatherDetailViewController") as? WeatherDetailViewController
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
    
    func testParentViewHasCollectionViewSubview() {
        XCTAssertTrue(self.sut.view.contains(self.sut.collectionView), "View does not have a collection view subview")
    }
    
    func testThatCollectionViewLoads() {
        XCTAssertNotNil(self.sut.collectionView, "Collection view is not connected to an IBOutlet")
    }
}


//Mark: CollectionView tests
extension WeatherDetailViewControllerTest {
    func testThatViewConformsToUICollectionViewDataDelegate() {
        XCTAssertTrue(self.sut.conforms(to: UICollectionViewDelegate.self), "View does not conform to UICollectionView delegate protocol")
    }
    
    func testThatViewConformsToCollectionViewDataSource() {
        XCTAssertTrue(self.sut.conforms(to: UICollectionViewDataSource.self), "View does not conform to UICollectionView datasource protocol")
    }
    
    func testCollectionViewIsConnectedToDelegate() {
        XCTAssertNotNil(self.sut.collectionView.delegate, "CollectionView delegate cannot be nil")
    }

    func testCollectionViewIsConnectedToDataSource() {
        XCTAssertNotNil(self.sut.collectionView.dataSource, "CollectionView datasource cannot be nil")
    }
    
    func testCollectionViewNumberOfRowsInSection() {
        XCTAssertTrue(self.sut.collectionView.numberOfSections == 1, "collectionView must have 1 section")
    }
}
