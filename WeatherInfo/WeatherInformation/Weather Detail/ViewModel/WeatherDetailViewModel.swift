//
//  WeatherDetailViewModel.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 16/04/21.
//

import Foundation

protocol WeatherDetailViewModelProtocol {
    func didReceiveAPISuccess()
    func didAPIFailWithError()
}

class WeatherDetailViewModel {
    
    var forecastData: [ForecastTemperature] = []
    var viewModelDelegate: WeatherDetailViewModelProtocol?
    var currentSelectedWeatherViewModel: WeatherViewModel?
    
    init() {
        self.fetchForcastData()
    }
    
    // Method to call API to Fetch currect selected city's Forcast
    func fetchForcastData() {
        WeatherAPI.shared.fetchNextFiveWeatherForecast(city: "Jodhpur") { [weak self] (forecast) in
            guard let `self` = self else { return }
            self.forecastData = forecast
            if let delegate = self.viewModelDelegate {
                delegate.didReceiveAPISuccess()
            }
        }
    }
    
    // Method to return nmumber of rows
    func numberofrow() -> Int {
        return forecastData.count
    }
    
    // Method to return
    func itemAt(index: Int) -> ForecastTemperature {
        return forecastData[index]
    }
    
    var currentSelectedCityName: String {
        return self.currentSelectedWeatherViewModel?.cityName.capitalized ?? ""
    }
    
    var currentSelectedCityTemperature: String {
        return (self.currentSelectedWeatherViewModel?.temperature ?? "")
    }
    
    var currentSelectedCityHumidity: String {
        return (self.currentSelectedWeatherViewModel?.humidity ?? "")
    }
    
    var currentSelectedCityMinTemp: String {
        return (self.currentSelectedWeatherViewModel?.minTemperature ?? "")
    }
    
    var currentSelectedCityMaxTemp: String {
        return (self.currentSelectedWeatherViewModel?.maxTemperature ?? "")
    }
    
}
