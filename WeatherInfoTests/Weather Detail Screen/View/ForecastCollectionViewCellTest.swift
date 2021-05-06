//
//  ForecastCollectionViewCellTest.swift
//  WeatherInfoTests
//
//  Created by Hemant Soni on 23/04/21.
//

import XCTest
@testable import WeatherInfo

class ForecastCollectionViewCellTest: XCTestCase {
    
    private var forecastCollectionViewCell: ForecastCollectionViewCell!
    private var collectionView: UICollectionView!
    private var dailyForecast: [WeatherInfo] = []

    private var dataSource: CollectionViewDataSource!
    
    override func setUp() {
        // Append some city data in cityData
        // check if user has already set the temp unit choice
        dailyForecast.append(WeatherInfo(temp: 311.0, min_temp:311.0, max_temp: 311.0, description: "Clear Sky", icon: "@021", time: ""))

        // Create an instance of UICollectionViewFlowLayout since you cant
        // Initialize UICollectionView without a layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 300, height: 400)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 400), collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "ForecastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ForecastCollectionViewCell")

        dataSource = CollectionViewDataSource()
        collectionView.dataSource = dataSource
    }
    
    func testAwakeFromNib() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = createCell(indexPath: indexPath)
        cell.configureCollectionView()
        cell.collectionView.reloadData()
        XCTAssertNotNil(cell.weekDayLabel, "weekDayLabel should not be nil")
        XCTAssertNotNil(cell.collectionView, "collectionView should not be nil")
    }
}

extension ForecastCollectionViewCellTest {
    func createCell(indexPath: IndexPath) -> ForecastCollectionViewCell {
        let cell = dataSource.collectionView(collectionView, cellForItemAt: indexPath) as! ForecastCollectionViewCell
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCollectionViewCell.reuseIdentifier, for: indexPath) as! ForecastCollectionViewCell
        return cell
    }
}
