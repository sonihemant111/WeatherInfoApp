//
//  WeatherListViewModel.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 13/04/21.
//

import Foundation

class WeatherListViewModel {
    var updateUI: ((_ weatherData: WeatherData) -> Void)?
    
    // Method to get Weather Data according tio input
    func getWeatherData(cityName: String, scale: TemperatureScale) {
        WeatherAPI.shared.getCurrentWeather(cityName: cityName, tempScale: scale) { (data) in
            self.updateUI(weatherData: data, scale: scale)
        }
    }
    
    // Update UI Once we fetch the weather data
    func updateUI(weatherData: WeatherData, scale: TemperatureScale) {
        DispatchQueue.main.async {
            guard let closure = self.updateUI else { return }
            closure(weatherData)
        }
    }
}

