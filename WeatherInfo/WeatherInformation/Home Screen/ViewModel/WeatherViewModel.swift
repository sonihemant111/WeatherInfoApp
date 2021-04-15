//
//  WeatherViewModel.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 13/04/21.
//

import Foundation
class WeatherViewModel {
    
    var weatherData: WeatherData
    var indexPath: IndexPath?
    
    var updateUI: ((_ weatherViewModel: WeatherViewModel, _ indexPath: IndexPath) -> Void)?
    
    init() {
        weatherData = WeatherData()
    }
    
    // Method to get Weather Data according tio input
    func getWeatherData(cityName: String, scale: TemperatureScale) {
        WeatherAPI.shared.getCurrentWeather(cityName: cityName, tempScale: scale) { [weak self] (data) in
            guard let `self` = self, let closure = self.updateUI, let indexPath = self.indexPath else { return }
            self.weatherData = data
            closure(self, indexPath)
        }
    }
    
    var cityName: String {
        return weatherData.name?.capitalized ?? ""
    }
    
    var temperature: String {
        if (weatherData.main.temp?.description ?? "").isEmpty {
            return ""
        } else {
            return ((weatherData.main.temp?.description ?? "") + "\(TemperatureScale.fahrenheit.symbolForScale())")
        }
    }
}
