//
//  WeatherViewModel.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 13/04/21.
//

import Foundation

protocol WeatherViewModelProtocol {
    func didReceiveTemperatureData(_ indexPath: IndexPath)
    func didFailWithError(_ indexPath: IndexPath)
}

class WeatherViewModel {
    
    var weatherData: WeatherModel
    var indexPath: IndexPath?
    var delegate: WeatherViewModelProtocol?
    
    var updateUI: ((_ weatherViewModel: WeatherViewModel, _ indexPath: IndexPath) -> Void)?
    
    init() {
        weatherData = WeatherModel()
    }
    
    // Method to get Weather Data according to input
    func getWeatherData() {
        guard self.indexPath != nil else { return }
        
        if (AppNetworking.isConnected()) {
            WeatherAPI.shared.fetchCurrentWeather(cityName: weatherData.name ?? "" , tempScale: TemperatureScale.getUserSavedSettingTempUnitType()) { [weak self] (data, err)  in
                
                guard let `self` = self else { return }
                
                if err != nil {
                    self.weatherData.isRefreshNeeded = true
                } else {
                    guard let weatherData = data, let delegate = self.delegate, let indexPath = self.indexPath else { return }
                    self.weatherData.isRefreshNeeded = false
                    let cityID: Int64 = self.weatherData.cityID ?? 0
                    self.weatherData = weatherData
                    self.weatherData.cityID = cityID
                    delegate.didReceiveTemperatureData(indexPath)
                }
            }
        } else {
            guard let delegate = self.delegate, let indexPath = self.indexPath else { return }
            self.weatherData.isRefreshNeeded = true
            delegate.didFailWithError(indexPath)
        }
    }
    
    var cityName: String {
        return weatherData.name?.capitalized ?? ""
    }
    
    var countryName: String {
        return (weatherData.sys.country ?? "").capitalized 
    }
    
    var cityID: Int64 {
        return weatherData.cityID ?? 0
    }
    
    var temperature: String {
        if (weatherData.main.temp?.description ?? "").isEmpty {
            return ""
        } else {
            return ((weatherData.main.temp?.description ?? "") + "\(TemperatureScale.getUserSavedSettingTempUnitType().symbolForScale())")
        }
    }
    
    var humidity: String {
        if (weatherData.main.humidity?.description ?? "").isEmpty {
            return ""
        } else {
            return (weatherData.main.humidity?.description ?? "") + "\(TemperatureScale.getUserSavedSettingTempUnitType().symbolForScale())"
        }
    }
    
    var minTemperature: String {
        if (weatherData.main.temp_min?.description ?? "").isEmpty {
            return ""
        } else {
            return (weatherData.main.temp_min?.description ?? "") + "\(TemperatureScale.getUserSavedSettingTempUnitType().symbolForScale())"
        }
    }
    
    var maxTemperature: String {
        if (weatherData.main.temp_max?.description ?? "").isEmpty {
            return ""
        } else {
            return (weatherData.main.temp_max?.description ?? "") + "\(TemperatureScale.getUserSavedSettingTempUnitType().symbolForScale())"
        }
    }
    
    var isRefreshNeeded: Bool {
        return (weatherData.isRefreshNeeded)
    }
}
