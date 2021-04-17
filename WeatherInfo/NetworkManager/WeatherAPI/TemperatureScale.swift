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
    
    static func getUserSavedSettingTempUnitType() -> TemperatureScale {
        let settingsModel = UserDefaults.standard.getUserSavedSettings()
        
        if let tempUnit = settingsModel?.tempUnit.lowercased() {
            if tempUnit == "fahrenheit" {
                return TemperatureScale.fahrenheit
            } else if tempUnit == "celsius" {
                return TemperatureScale.celsius
            }
        }
        return .fahrenheit
    }
}
