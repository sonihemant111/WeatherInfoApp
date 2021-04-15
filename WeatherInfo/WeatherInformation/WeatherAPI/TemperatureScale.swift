//
//  TemperatureScale.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 14/04/21.
//

import Foundation

enum TemperatureScale: String {
    case celsius = "metric"
    case kelvin = "kelvin"
    case fahrenheit = "imperial"
    
    func symbolForScale() -> String {
        switch(self) {
        case .celsius:
            return "℃"
        case .kelvin:
            return "K"
        case .fahrenheit:
            return "℉"
        }
    }
}
