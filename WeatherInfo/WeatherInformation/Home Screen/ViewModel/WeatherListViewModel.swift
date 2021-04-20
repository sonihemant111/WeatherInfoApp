//
//  WeatherListViewModel.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 13/04/21.
//

import Foundation

protocol WeatherListViewModelProtocol {
    func didReceiveWeatherDetailsAt(_ indexPath: IndexPath)
}

class WeatherListViewModel {
    var weatherViewModels = [WeatherViewModel]()
    var delegate: WeatherListViewModelProtocol?
    let dbManager = DBManager()
    
    // Method to add new weather view model
    func addWeatherViewModel(_ weatherViewModel: WeatherViewModel) {
        weatherViewModels.append(weatherViewModel)
    }
    
    // Update UI Once we fetch the weather data
    func updateUI(_ indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }
        delegate.didReceiveWeatherDetailsAt(indexPath)
    }
        
    // Method to fetch selected cities including default three cities
    func fetchSelectedCities() {
        let arrCity = dbManager.fetchAllSelectedCities()
        if arrCity.count > 0 {
            for i in 0...arrCity.count - 1 {
                let weatherViewModel = WeatherViewModel()
                weatherViewModel.weatherData.name = arrCity[i].0
                weatherViewModel.weatherData.cityID = arrCity[i].1
                weatherViewModel.indexPath = IndexPath(row: weatherViewModels.count, section: 0)
                weatherViewModel.delegate = self
                weatherViewModel.getWeatherData()
                weatherViewModels.append(weatherViewModel)
            }
        }
    }
    
    // Method to refesh data
    func refreshTemperatureData() {
        if weatherViewModels.count > 0 {
            for weatherViewModel in 0...weatherViewModels.count - 1 {
                let viewModel = weatherViewModels[weatherViewModel]
                viewModel.getWeatherData()
            }
        }
    }
    
    // Add new City to get weather
    func addNewCity(_ cityName: String, _ cityId: Int64) {
        let weatherViewModel = WeatherViewModel()
        weatherViewModel.weatherData.name = cityName
        weatherViewModel.weatherData.cityID = cityId
        weatherViewModel.indexPath = IndexPath(row: weatherViewModels.count, section: 0)
        weatherViewModel.delegate = self
        weatherViewModel.getWeatherData()
        weatherViewModels.append(weatherViewModel)
    }
        
    // Method to get number of section
    func numberOfSection() -> Int {
        return 1
    }
    
    // Method to get number of rows
    func numberOfRows(_ section: Int) -> Int {
        return weatherViewModels.count
    }
    
    // Method to get model(WeatherViewModel) on specific index
    func itemAt(_ index: Int) -> WeatherViewModel {
        return weatherViewModels[index]
    }
    
    // Method to remove item at specific index
    func removeItemAt(_ index: Int) {
        weatherViewModels.remove(at: index)
    }
}

// MARK: WeatherViewModelProtocol
extension WeatherListViewModel: WeatherViewModelProtocol {
    func didFailWithError(_ indexPath: IndexPath, _ err: Error) {
        self.updateUI(indexPath)
    }
    
    func didReceiveTemperatureData(_ indexPath: IndexPath) {
        self.updateUI(indexPath)
    }
}
