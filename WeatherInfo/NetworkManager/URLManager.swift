//
//  URLManager.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 14/04/21.
//

import Foundation

class URLManager {
    private let APIBaseURL: String = "http://api.openweathermap.org/"
    private let baseURL: String = "http://openweathermap.org"
    
    var fetchWeather: String {
        return APIBaseURL + "data/2.5/weather?q="
    }
    
    var fetchIconImage: String {
        return baseURL + "/img/wn/"
    }
    
    var fetchForcastInfo: String {
        return APIBaseURL + "data/2.5/forecast?q="
    }
}
