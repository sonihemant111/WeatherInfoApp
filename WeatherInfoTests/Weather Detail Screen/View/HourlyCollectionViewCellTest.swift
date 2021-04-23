//
//  HourlyCollectionViewCellTest.swift
//  WeatherInfoTests
//
//  Created by Hemant Soni on 23/04/21.
//

import XCTest
@testable import WeatherInfo

class HourlyCollectionViewCellTest: XCTestCase {
    
    private var hourlyCustomTableViewCell: HourlyCollectionViewCell!
    private var collectionView: UICollectionView!
    private var weatherInfo: WeatherInfo?

    private var dataSource: CollectionViewDataSource!
    
    override func setUp() {
        // Append some city data in cityData
        // check if user has already set the temp unit choice
        weatherInfo = WeatherInfo(temp: 311.0, min_temp:311.0, max_temp: 311.0, description: "Clear Sky", icon: "@021", time: "")

        // Create an instance of UICollectionViewFlowLayout since you cant
        // Initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 300, height: 400)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 400), collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "HourlyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HourlyCollectionViewCell")

        dataSource = CollectionViewDataSource()
        collectionView.dataSource = dataSource
    }
    
    func testAwakeFromNib() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = createCell(indexPath: indexPath)
        if let weatherInfo = self.weatherInfo {
            cell.configure(with: weatherInfo)
            
            XCTAssertNotNil(cell.hourlyTimeLabel, "hourlyTimeLabel should not be nil")
            XCTAssertNotNil(cell.temperatureSymbol, "temperatureSymbol should not be nil")
            XCTAssertNotNil(cell.temperatureLabel, "temperatureLabel should not be nil")

            XCTAssertEqual(cell.temperatureLabel.text, "100.13", "temperatureUnit Label text should be fahrenheit")
            XCTAssertEqual(cell.hourlyTimeLabel.text, "", "temperatureUnit Label text should be empty")

        }
        
    }
}

extension HourlyCollectionViewCellTest {
    func createCell(indexPath: IndexPath) -> HourlyCollectionViewCell {
        let cell = dataSource.collectionView(collectionView, cellForItemAt: indexPath) as! HourlyCollectionViewCell
        XCTAssertNotNil(cell)

        let view = cell.contentView
        XCTAssertNotNil(view)
        return cell
    }
}


private class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var WeatherInfos = [WeatherInfo]()
    
    override init() {
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WeatherInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.reuseIdentifier, for: indexPath) as! HourlyCollectionViewCell
        return cell
    }
}
