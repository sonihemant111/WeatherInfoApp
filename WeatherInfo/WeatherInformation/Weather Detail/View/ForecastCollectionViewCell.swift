//
//  ForecastCollectionViewCell.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 15/04/21.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    static var reuseIdentifier: String = "ForecastCollectionViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var weekDayLabel: UILabel!
    
    var dailyForecast: [WeatherInfo] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Method to configure Collection View
    func configureCollectionView() {
        self.collectionView.collectionViewLayout = self.createCompositionalLayout()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "HourlyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: HourlyCollectionViewCell.reuseIdentifier)
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            self.createFeaturedSection()
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        layout.configuration = config
        return layout
    }
        
    func createFeaturedSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(0.75))

       let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
       layoutItem.contentInsets = NSDirectionalEdgeInsets(top:20, leading: 5, bottom: 0, trailing: 5)

       let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(110))
       let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])

       let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
       layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
       return layoutSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyForecast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.reuseIdentifier, for: indexPath) as! HourlyCollectionViewCell
        cell.configure(with: dailyForecast[indexPath.row])
        return cell
    }
    
    func configure(with item: ForecastTemperature) {
        weekDayLabel.text = item.weekDay
        dailyForecast = item.hourlyForecast ?? []
    }

}
