//
//  WeatherDetailViewController.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 15/04/21.
//

import UIKit

class WeatherDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var cityAndCountryNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var minimumTempLabel: UILabel!
    @IBOutlet weak var maximumTempLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = WeatherDetailViewModel()
    var currentSelectedWeatherViewModel: WeatherViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        viewModel.viewModelDelegate = self
        viewModel.currentSelectedWeatherViewModel = self.currentSelectedWeatherViewModel
        viewModel.fetchForcastData()
        displayCurentSelectedCityData()
        configureNavigationBar()
    }
    
    // Method to configure Navigation Bar
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
    }
    
    // func display Current selected city's Weather Data
    func displayCurentSelectedCityData() {
        self.cityAndCountryNameLabel.text = viewModel.currentSelectedCityName + ", " + viewModel.currentSelectedCountryName
        self.temperatureLabel.text = viewModel.currentSelectedCityTemperature
        self.dateLabel.text = viewModel.currentDate
        self.minimumTempLabel.text = viewModel.currentSelectedCityMinTemp
        self.maximumTempLabel.text = viewModel.currentSelectedCityMaxTemp
        self.humidityLabel.text = viewModel.currentSelectedCityHumidity
    }
    
    // Method to configure Collection View
    func configureCollectionView() {
        // set custom layout and register a nib (Cell)
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.register(UINib(nibName: "ForecastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ForecastCollectionViewCell.reuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: UICollectionViewDelegate and Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberofRow()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCollectionViewCell.reuseIdentifier, for: indexPath) as! ForecastCollectionViewCell
        cell.configureCollectionView()
        cell.configure(with: viewModel.itemAt(index: indexPath.row))
        return cell
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top:5, leading: 5, bottom: 0, trailing: 5)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(110))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])
        
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        // layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        return layoutSection
    }
}

// MARK: WeatherDetailViewModelProtocol
extension WeatherDetailViewController: WeatherDetailViewModelProtocol {
    func didReceiveAPISuccess() {
        // reload collectionview
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func didAPIFailWithError() {
        // Show toast message
    }
}
