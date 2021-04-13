//
//  WeatherAPI.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 13/04/21.
//

import Foundation

class WeatherAPI {
    
    // Method to get weather API Key
    func getAPIKey() -> String? {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
        let dictionary = NSDictionary(contentsOfFile: path) as? [String: Any], let key = dictionary["WeatherAPIKey"] as? String {
            return key
        }
        return nil
    }
}
