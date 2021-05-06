//
//  URLManager.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 14/04/21.
//

import Foundation

class URLManager {
    private let APIBaseURL: String = "http://api.openweathermap.org/"
    private let weatherAPIBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    private let baseURL: String = "https://openweathermap.org/"
    
    // Method to return API Key
    private func getAPIKey() -> String? {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
           let dictionary = NSDictionary(contentsOfFile: path) as? [String: Any], let key = dictionary["WeatherAPIKey"] as? String {
            return key
        }
        return nil
    }
    
    var fetchIconImage: String {
        return baseURL + "/img/wn/"
    }
    
    var fetchForcastInfo: String {
        return APIBaseURL + "data/2.5/forecast?q="
    }
    
    func getURLToFetchWeatherOfCity(city: String, tempUnit: String) -> String {
        return weatherAPIBaseURL + "?q=" + city + "&units=" + tempUnit + "&APPID=" + (self.getAPIKey() ?? "")
    }
    
    func getURLToFetchForecastOfCity(city: String) -> String {
        return fetchForcastInfo + city + "&appid=" + (self.getAPIKey() ?? "")
    }
}

