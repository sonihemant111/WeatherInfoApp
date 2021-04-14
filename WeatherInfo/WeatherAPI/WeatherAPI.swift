//
//  WeatherAPI.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 13/04/21.
//

import Foundation

class WeatherAPI {
    static let shared = WeatherAPI()
    private let request = RequestManager()
    
    func getCurrentWeather(cityName: String, tempScale: TemperatureScale, completionHandler: @escaping ((WeatherData) -> ())) {
        
        guard let sanitizedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
            print("Error: while sanitizing city name")
            return
        }
        
        guard let key = getAPIKey() else {
            print("Error: could not extract API key")
            return
        }
        
        // Set up the URL request
        let endpointString = "https://api.openweathermap.org/data/2.5/weather?q=\(sanitizedCityName)&units=\(tempScale.rawValue)&APPID=\(key)"
        
        print("final request string:", endpointString)
        
        guard let url = URL(string: endpointString) else {
            print("error: URL NOT valid")
            return
        }
        print("final request string:", endpointString)
        
        request.get(with: url) { (data, error) in
            // Check for any errors
            if let error = error {
                print("error calling GET on current weather:", error.localizedDescription)
                return
            }
            
            // Make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            do {
                guard let jsonData = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else {
                    print("Error trying to convert data to JSON")
                    return
                }
                print(jsonData)
                
                // Parse the result as JSON, since that's what the API provides
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherData.self, from: responseData)
                completionHandler(weatherData)
            } catch {
                print("Error: conversion to JSON")
            }
        }
    }
    
    // Method to get weather API Key
    func getAPIKey() -> String? {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
        let dictionary = NSDictionary(contentsOfFile: path) as? [String: Any], let key = dictionary["WeatherAPIKey"] as? String {
            return key
        }
        return nil
    }
}
