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
        self.setupCities()
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
    func setupCities() {
        let weatherViewModelSydney = WeatherViewModel()
        weatherViewModelSydney.weatherData.name = "Sydney"
        weatherViewModels.append(weatherViewModelSydney)
        weatherViewModelSydney.indexPath = IndexPath(row: weatherViewModels.count - 1, section: 0)
        weatherViewModelSydney.getWeatherData(cityName: "Sydney", scale: .fahrenheit)
        weatherViewModelSydney.updateUI = { [weak self] (weatherViewModel, indexPath) in
            guard let `self` = self else { return }
            self.weatherViewModels[indexPath.row] = weatherViewModel
            self.updateUI(indexPath)
        }

        let weatherViewModelMelbourne = WeatherViewModel()
        weatherViewModelMelbourne.weatherData.name = "Melbourne"
        weatherViewModels.append(weatherViewModelMelbourne)
        weatherViewModelMelbourne.indexPath = IndexPath(row: weatherViewModels.count - 1, section: 0)
        weatherViewModelMelbourne.getWeatherData(cityName: "Melbourne", scale: .fahrenheit)
        weatherViewModelMelbourne.updateUI = { [weak self] (weatherViewModel, indexPath) in
            guard let `self` = self else { return }
            self.weatherViewModels[indexPath.row] = weatherViewModel
            self.updateUI(indexPath)
        }
        
        let weatherViewModelBrisbane = WeatherViewModel()
        weatherViewModelBrisbane.weatherData.name = "Brisbane"
        weatherViewModels.append(weatherViewModelBrisbane)
        weatherViewModelBrisbane.indexPath = IndexPath(row: weatherViewModels.count - 1, section: 0)
        weatherViewModelBrisbane.getWeatherData(cityName: "Brisbane", scale: .fahrenheit)
        weatherViewModelBrisbane.updateUI = { [weak self] (weatherViewModel, indexPath) in
            guard let `self` = self else { return }
            self.weatherViewModels[indexPath.row] = weatherViewModel
            self.updateUI(indexPath)
        }
    }
        
    // Method to get number of section
    func getNumberOfSection() -> Int {
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

