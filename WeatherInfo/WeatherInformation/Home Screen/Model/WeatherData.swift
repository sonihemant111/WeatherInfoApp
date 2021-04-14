//
//  WeatherData.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 14/04/21.
//

import Foundation

struct WeatherData: Codable {
    let dt: Int
    let main: MainData
    let weather: [WeatherConditions]
}

struct MainData: Codable {
    let temp: Double
    let pressure: Int?
    let humidity: Float?
    let temp_min: Double?
    let temp_max: Double?
}

struct WeatherConditions: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
