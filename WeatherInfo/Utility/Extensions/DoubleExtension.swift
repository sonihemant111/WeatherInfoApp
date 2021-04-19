//
//  DoubleExtension.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 17/04/21.
//

import Foundation

// Extension of Double
extension Double {
    func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
    
    func kelvinToCeliusConverter() -> Double {
        let constantVal : Double = 273.15
        let kelValue = self
        let celValue = kelValue - constantVal
        return celValue.truncate(places: 1).truncate(places: 2)
    }
    
    func kelvinToFahrenheitConverter() -> Double{
        return (((self-273.15)*1.8)+32).truncate(places: 2)
    }
     
}
