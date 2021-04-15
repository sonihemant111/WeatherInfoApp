//
//  NetworkManagerProtocol.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 15/04/21.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchCurrentWeather(cityName: String, tempScale: TemperatureScale, completion: @escaping (WeatherModel?,  WeatherInfoError?) -> ())
//    func fetchCurrentLocationWeather(lat: String, lon: String, completion: @escaping (WeatherModel) -> ())
//    func fetchNextFiveWeatherForecast(city: String, completion: @escaping ([ForecastTemperature]) -> ())
}
