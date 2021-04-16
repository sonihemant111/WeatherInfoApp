//
//  WeatherViewModel.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 13/04/21.
//

import Foundation
class WeatherViewModel {
    
    var weatherData: WeatherModel
    var indexPath: IndexPath?
    
    var updateUI: ((_ weatherViewModel: WeatherViewModel, _ indexPath: IndexPath) -> Void)?
    
    init() {
        weatherData = WeatherModel()
    }
    
    // Method to get Weather Data according to input
    func getWeatherData() {
        guard let closure = self.updateUI, let indexPath = self.indexPath else { return }
        
        if (AppNetworking.isConnected()) {
            WeatherAPI.shared.fetchCurrentWeather(cityName: weatherData.name ?? "" , tempScale: .fahrenheit) { [weak self] (data, err)  in
                guard let `self` = self, let weatherData = data else { return }
                if err != nil {
                    self.weatherData.isRefreshNeeded = true
                } else {
                    self.weatherData.isRefreshNeeded = false
                    self.weatherData = weatherData
                }
                closure(self, indexPath)
            }
        } else {
            self.weatherData.isRefreshNeeded = true
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
    
    var humidity: String {
        if (weatherData.main.humidity?.description ?? "").isEmpty {
            return ""
        } else {
            return (weatherData.main.humidity?.description ?? "")
        }
    }
    
    var minTemperature: String {
        if (weatherData.main.temp_min?.description ?? "").isEmpty {
            return ""
        } else {
            return (weatherData.main.temp_min?.description ?? "")
        }
    }
    
    var maxTemperature: String {
        if (weatherData.main.temp_max?.description ?? "").isEmpty {
            return ""
        } else {
            return (weatherData.main.temp_max?.description ?? "")
        }
    }
    
    var isRefreshNeeded: Bool {
        return (weatherData.isRefreshNeeded)
    }
}
