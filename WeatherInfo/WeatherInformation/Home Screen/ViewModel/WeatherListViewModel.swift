//
//  WeatherListViewModel.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 13/04/21.
//

import Foundation

class WeatherListViewModel {
    var weatherViewModels = [WeatherViewModel]()
    var updateUI: ((_ indexPath: IndexPath) -> Void)?
    
    init() {
        self.setupDefaultCities()
    }
    
    // Method to add new weather view model
    func addWeatherViewModel(_ weatherViewModel: WeatherViewModel) {
        weatherViewModels.append(weatherViewModel)
    }
    
    // Update UI Once we fetch the weather data
    func updateUI(_ indexPath: IndexPath) {
        guard let closure = self.updateUI else { return }
        closure(indexPath)
    }
    
    // As per the requirement we have to show below three cities weather data on Home Page
    // Sydney, Melbourne and Brisbane
    func setupDefaultCities() {
        let weatherViewModelSydney = WeatherViewModel()
        weatherViewModelSydney.weatherData.name = "Sydney"
        weatherViewModels.append(weatherViewModelSydney)
        weatherViewModelSydney.indexPath = IndexPath(row: weatherViewModels.count - 1, section: 0)
        weatherViewModelSydney.updateUI = { [weak self] (weatherViewModel, indexPath) in
            guard let `self` = self else { return }
            self.weatherViewModels[indexPath.row] = weatherViewModel
            self.updateUI(indexPath)
        }
        weatherViewModelSydney.getWeatherData()


        let weatherViewModelMelbourne = WeatherViewModel()
        weatherViewModelMelbourne.weatherData.name = "Melbourne"
        weatherViewModels.append(weatherViewModelMelbourne)
        weatherViewModelMelbourne.indexPath = IndexPath(row: weatherViewModels.count - 1, section: 0)
        weatherViewModelMelbourne.updateUI = { [weak self] (weatherViewModel, indexPath) in
            guard let `self` = self else { return }
            self.weatherViewModels[indexPath.row] = weatherViewModel
            self.updateUI(indexPath)
        }
        weatherViewModelMelbourne.getWeatherData()
        
        let weatherViewModelBrisbane = WeatherViewModel()
        weatherViewModelBrisbane.weatherData.name = "Brisbane"
        weatherViewModels.append(weatherViewModelBrisbane)
        weatherViewModelBrisbane.indexPath = IndexPath(row: weatherViewModels.count - 1, section: 0)
        weatherViewModelBrisbane.updateUI = { [weak self] (weatherViewModel, indexPath) in
            guard let `self` = self else { return }
            self.weatherViewModels[indexPath.row] = weatherViewModel
            self.updateUI(indexPath)
        }
        weatherViewModelBrisbane.getWeatherData()

    }
    
    // Add new City to get weather
    func addNewCity(_ cityName: String) {
        let weatherViewModel = WeatherViewModel()
        weatherViewModel.weatherData.name = cityName
        weatherViewModels.append(weatherViewModel)
        weatherViewModel.indexPath = IndexPath(row: self.numberOfRows(0) - 1, section: 0)
        weatherViewModel.updateUI = { [weak self] (weatherViewModel, indexPath) in
            guard let `self` = self else { return }
            print(indexPath.row)
            print(self.weatherViewModels.count)
            
            self.weatherViewModels[indexPath.row - 1] = weatherViewModel
            self.updateUI(indexPath)
        }
        weatherViewModel.getWeatherData()
    }
        
    // Method to get number of section
    func numberOfSection() -> Int {
        return 1
    }
    
    // Method to get number of rows
    func numberOfRows(_ section: Int) -> Int {
        return weatherViewModels.count
    }
    
    // Method to get model(WeatherViewModel) on sprcific index
    func modelAt(_ index: Int) -> WeatherViewModel {
        return weatherViewModels[index]
    }
}

