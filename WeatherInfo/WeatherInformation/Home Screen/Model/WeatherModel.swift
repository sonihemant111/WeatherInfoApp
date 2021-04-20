//
//  WeatherModel.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 14/04/21.
//

import Foundation
 
enum WeatherInfoError: Error {
    case noDataFound
    case noInternetConnection
}

struct WeatherModel: Codable {
    var dt: Int?
    var cityID: Int64?
    var name: String?
    var main = Main()
    var sys = Sys()
    let timezone: Int64 = 0
    var dt_txt: String?
    var weather = [Weather]()
    var isRefreshNeeded: Bool = false
    
    private enum CodingKeys : String, CodingKey {
        case dt, name, main, weather, sys, dt_txt, timezone
    }
}

struct Sys: Codable {
    var country: String?
}

struct Main: Codable {
    var temp: Double?
    var feels_like: Float?
    var pressure: Int?
    var humidity: Float?
    var temp_min: Double?
    var temp_max: Double?
}

struct Weather: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct ForecastModel: Codable {
    var list: [WeatherModel]
    let city: City
}

struct City: Codable {
    let name: String?
    let country: String?
}

struct WeatherInfo {
    let temp: Double
    let min_temp: Double
    let max_temp: Double
    let description: String
    let icon: String
    let time: String
}

struct ForecastTemperature {
    let weekDay: String?
    let hourlyForecast: [WeatherInfo]?
}
