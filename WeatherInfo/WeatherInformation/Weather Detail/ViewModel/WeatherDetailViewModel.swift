//
//  WeatherDetailViewModel.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 16/04/21.
//

import Foundation

protocol WeatherDetailViewModelProtocol: class {
    func didReceiveAPISuccess()
    func didAPIFailWithError(_ error: WeatherInfoError)
}

class WeatherDetailViewModel {
    
    var forecastData: [ForecastTemperature] = []
    weak var viewModelDelegate: WeatherDetailViewModelProtocol?
    var currentSelectedWeatherViewModel: WeatherViewModel?
    
    // Method to call API to Fetch currect selected city's Forcast
    func fetchForcastData() {
        WeatherAPI.shared.fetchNextFiveWeatherForecast(city: currentSelectedWeatherViewModel?.cityName ?? "") { [weak self] (forecast, error) in
            
            guard let `self` = self, let delegate = self.viewModelDelegate  else { return }
            if let err = error {
                delegate.didAPIFailWithError(err)
            } else {
                if let forecastData = forecast {
                    self.forecastData = forecastData
                    delegate.didReceiveAPISuccess()
                }
            }
        }
    }
    
    // Method to return nmumber of rows
    func numberofRow() -> Int {
        return forecastData.count
    }
    
    // Method to return ForecastTemperature
    func itemAt(index: Int) -> ForecastTemperature {
        return forecastData[index]
    }
    
    // To get selected city Name
    var currentSelectedCityName: String {
        return self.currentSelectedWeatherViewModel?.cityName.capitalized ?? ""
    }
    
    // To get selected city's Country Name
    var currentSelectedCountryName: String {
        return self.currentSelectedWeatherViewModel?.countryName.capitalized ?? ""
    }
    
    // To get selected city's temp
    var currentSelectedCityTemperature: String {
        return (self.currentSelectedWeatherViewModel?.temperature ?? "")
    }
    
    // To get selected city's Humidity
    var currentSelectedCityHumidity: String {
        return (self.currentSelectedWeatherViewModel?.humidity ?? "")
    }
    
    // To get selected city's min Temp
    var currentSelectedCityMinTemp: String {
        return (self.currentSelectedWeatherViewModel?.minTemperature ?? "")
    }
    
    // to get current date
    var currentDate: String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
    
    // To get selected city's min Temp
    var currentSelectedCityMaxTemp: String {
        return (self.currentSelectedWeatherViewModel?.maxTemperature ?? "")
    }
}
