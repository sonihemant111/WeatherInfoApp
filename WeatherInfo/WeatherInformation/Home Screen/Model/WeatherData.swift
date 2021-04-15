//
//  WeatherData.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 14/04/21.
//

import Foundation

enum WeatherInfoError {
    case noDataFound
    case noInternetConnection
}

struct WeatherData: Codable {
    var dt: Int?
    var name: String?
    var main = MainData()
    var weather = [WeatherConditions]()
    var isRefreshNeeded: Bool = false
    
    private enum CodingKeys : String, CodingKey {
        case dt, name, main, weather
    }
}

struct MainData: Codable {
    var temp: Double?
    var pressure: Int?
    var humidity: Float?
    var temp_min: Double?
    var temp_max: Double?
}

struct WeatherConditions: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}
