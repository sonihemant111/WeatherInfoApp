//
//  URLManager.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 14/04/21.
//

import Foundation

class URLManager {
    private let baseURL: String = "https://api.openweathermap.org/"
    
    var fetchWeather: String {
        return baseURL + "data/2.5/weather?q="
    }
}
