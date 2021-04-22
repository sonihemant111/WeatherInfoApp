//
//  WeatherAPI.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 13/04/21.
//

import Foundation

class WeatherAPI: NetworkManagerProtocol {
    
    static let shared = WeatherAPI()
    private let request = RequestManager()

    // Method to fetch weather of specific city
    func fetchCurrentWeather(cityName: String, tempScale: TemperatureScale, completion: @escaping (WeatherModel?, WeatherInfoError?) -> ()) {
        guard let sanitizedCityName = cityName.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
            print("Error: while sanitizing city name")
            completion(nil, .someWentWrong)
            return
        }
        
        // Set up the URL request
        let endpointString = (URLManager.init().getURLToFetchWeatherOfCity(city: sanitizedCityName, tempUnit: tempScale.rawValue))
        
        print("final request string:", endpointString)
        
        guard let url = URL(string: endpointString) else {
            print("error: URL NOT valid")
            completion(nil, .someWentWrong)
            return
        }
        print("final request string:", endpointString)
        
        request.get(with: url) { (data, error) in
            // Check for any errors
            if let error = error {
                print("error calling GET on current weather:", error.localizedDescription)
                completion(nil, .someWentWrong)
                return
            }
            
            // Make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                completion(nil, .noDataFound)
                completion(nil, .noDataFound)
                return
            }
            
            do {
                guard let jsonData = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else {
                    print("Error trying to convert data to JSON")
                    completion(nil, .noDataFound)
                    return
                }
                print(jsonData)
                
                // Parse the result as JSON, since that's what the API provides
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherModel?.self, from: responseData)
                completion(weatherData, nil)
            } catch {
                print("Error: conversion to JSON")
                completion(nil, .noDataFound)
            }
        }
    }
    
    // Method to fetch forcast of specific city
    func fetchNextFiveWeatherForecast(city: String, completion: @escaping ([ForecastTemperature]?, WeatherInfoError?) -> ()) {
        // remove diacritics string example één to een from cityname
        let formattedCity = (city.folding(options: .diacriticInsensitive, locale: .current)).replacingOccurrences(of: " ", with: "+").stripped
        let API_URL = URLManager.init().getURLToFetchForecastOfCity(city: formattedCity)
        
        var currentDayTemp = ForecastTemperature(weekDay: nil, hourlyForecast: nil)
        var secondDayTemp = ForecastTemperature(weekDay: nil, hourlyForecast: nil)
        var thirdDayTemp = ForecastTemperature(weekDay: nil, hourlyForecast: nil)
        var fourthDayTemp = ForecastTemperature(weekDay: nil, hourlyForecast: nil)
        var fifthDayTemp = ForecastTemperature(weekDay: nil, hourlyForecast: nil)
        var sixthDayTemp = ForecastTemperature(weekDay: nil, hourlyForecast: nil)
        var seventhDayTemp = ForecastTemperature(weekDay: nil, hourlyForecast: nil)
        
        guard let url = URL(string: API_URL) else {
            fatalError()
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            guard self != nil else {
                completion(nil, .someWentWrong)
                return
            }
            
            guard let data = data else {
                completion(nil, .noDataFound)
                return
            }
            do {
                
                let forecastWeather = try JSONDecoder().decode(ForecastModel.self, from: data)
                
                var forecastmodelArray : [ForecastTemperature] = []
                var fetchedData : [WeatherInfo] = [] //Just for loop completion
                
                var currentDayForecast : [WeatherInfo] = []
                var secondDayForecast : [WeatherInfo] = []
                var thirddayDayForecast : [WeatherInfo] = []
                var fourthDayDayForecast : [WeatherInfo] = []
                var fifthDayForecast : [WeatherInfo] = []
                var sixthDayForecast : [WeatherInfo] = []
                var sevenDayForecast : [WeatherInfo] = []
                
                var totalData = forecastWeather.list.count //Should be 40 all the time
                
                for day in 0...forecastWeather.list.count - 1 {
                    
                    let listIndex = day//(8 * day) - 1
                    let mainTemp = forecastWeather.list[listIndex].main.temp
                    let minTemp = forecastWeather.list[listIndex].main.temp_min
                    let maxTemp = forecastWeather.list[listIndex].main.temp_max
                    let descriptionTemp = forecastWeather.list[listIndex].weather[0].description
                    let icon = forecastWeather.list[listIndex].weather[0].icon
                    let time = forecastWeather.list[listIndex].dt_txt ?? ""
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.calendar = Calendar(identifier: .gregorian)
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let date = dateFormatter.date(from: forecastWeather.list[listIndex].dt_txt ?? "")
                    
                    let calendar = Calendar.current
                    let components = calendar.dateComponents([.weekday], from: date!)
                    let weekdaycomponent = components.weekday! - 1  //Just the integer value from 0 to 6
                    
                    let f = DateFormatter()
                    let weekday = f.weekdaySymbols[weekdaycomponent] // 0 Sunday 6 - Saturday //This is where we are getting the string val (Mon/Tue/Wed...)
                    
                    let currentDayComponent = calendar.dateComponents([.weekday], from: Date())
                    let currentWeekDay = currentDayComponent.weekday! - 1
                    let currentweekdaysymbol = f.weekdaySymbols[currentWeekDay]
                    
                    if weekdaycomponent == currentWeekDay - 1 {
                        totalData = totalData - 1
                    }
                    
                    if weekdaycomponent == currentWeekDay {
                        let info = WeatherInfo(temp: mainTemp ?? 0.0, min_temp: minTemp ?? 0.0, max_temp: maxTemp ?? 0.0, description: descriptionTemp ?? "", icon: icon ?? "", time: time)
                        currentDayForecast.append(info)
                        currentDayTemp = ForecastTemperature(weekDay: currentweekdaysymbol, hourlyForecast: currentDayForecast)
                        fetchedData.append(info)
                    }else if weekdaycomponent == currentWeekDay.incrementWeekDays(by: 1) {
                        let info = WeatherInfo(temp: mainTemp ?? 0.0, min_temp: minTemp ?? 0.0, max_temp: maxTemp ?? 0.0, description: descriptionTemp ?? "", icon: icon ?? "", time: time)
                        secondDayForecast.append(info)
                        secondDayTemp = ForecastTemperature(weekDay: weekday, hourlyForecast: secondDayForecast)
                        fetchedData.append(info)
                    }else if weekdaycomponent == currentWeekDay.incrementWeekDays(by: 2) {
                        let info = WeatherInfo(temp: mainTemp ?? 0.0, min_temp: minTemp ?? 0.0, max_temp: maxTemp ?? 0.0, description: descriptionTemp ?? "", icon: icon ?? "", time: time)
                        thirddayDayForecast.append(info)
                        thirdDayTemp = ForecastTemperature(weekDay: weekday, hourlyForecast: thirddayDayForecast)
                        fetchedData.append(info)
                    }else if weekdaycomponent == currentWeekDay.incrementWeekDays(by: 3) {
                        let info = WeatherInfo(temp: mainTemp ?? 0.0, min_temp: minTemp ?? 0.0, max_temp: maxTemp ?? 0.0, description: descriptionTemp ?? "", icon: icon ?? "", time: time)
                        fourthDayDayForecast.append(info)
                        fourthDayTemp = ForecastTemperature(weekDay: weekday, hourlyForecast: fourthDayDayForecast)
                        fetchedData.append(info)
                    }else if weekdaycomponent == currentWeekDay.incrementWeekDays(by: 4){
                        let info = WeatherInfo(temp: mainTemp ?? 0.0, min_temp: minTemp ?? 0.0, max_temp: maxTemp ?? 0.0, description: descriptionTemp ?? "", icon: icon ?? "", time: time)
                        fifthDayForecast.append(info)
                        fifthDayTemp = ForecastTemperature(weekDay: weekday, hourlyForecast: fifthDayForecast)
                        fetchedData.append(info)
                    }else if weekdaycomponent == currentWeekDay.incrementWeekDays(by: 5) {
                        let info = WeatherInfo(temp: mainTemp ?? 0.0, min_temp: minTemp ?? 0.0, max_temp: maxTemp ?? 0.0, description: descriptionTemp ?? "", icon: icon ?? "", time: time)
                        sixthDayForecast.append(info)
                        sixthDayTemp = ForecastTemperature(weekDay: weekday, hourlyForecast: sixthDayForecast)
                        fetchedData.append(info)
                    }else if weekdaycomponent == currentWeekDay.incrementWeekDays(by: 6) {
                        let info = WeatherInfo(temp: mainTemp ?? 0.0, min_temp: minTemp ?? 0.0, max_temp: maxTemp ?? 0.0, description: descriptionTemp ?? "", icon: icon ?? "", time: time)
                        sevenDayForecast.append(info)
                        seventhDayTemp = ForecastTemperature(weekDay: weekday, hourlyForecast: sevenDayForecast)
                        fetchedData.append(info)
                    }
                    
                    
                    if fetchedData.count == totalData {
                        
                        if currentDayTemp.hourlyForecast?.count ?? 0 > 0 {
                            forecastmodelArray.append(currentDayTemp)
                        }
                        
                        if secondDayTemp.hourlyForecast?.count ?? 0 > 0 {
                            forecastmodelArray.append(secondDayTemp)
                        }
                        
                        if thirdDayTemp.hourlyForecast?.count ?? 0 > 0 {
                            forecastmodelArray.append(thirdDayTemp)
                        }
                        
                        if fourthDayTemp.hourlyForecast?.count ?? 0 > 0 {
                            forecastmodelArray.append(fourthDayTemp)
                        }
                        
                        if fifthDayTemp.hourlyForecast?.count ?? 0 > 0 {
                            forecastmodelArray.append(fifthDayTemp)
                        }
                        
                        if sixthDayTemp.hourlyForecast?.count ?? 0 > 0 {
                            forecastmodelArray.append(sixthDayTemp)
                        }
                        
                        if seventhDayTemp.hourlyForecast?.count ?? 0 > 0{
                            forecastmodelArray.append(seventhDayTemp)
                        }
                        
                        if forecastmodelArray.count <= 6 {
                            completion(forecastmodelArray, nil)
                        }
                        
                    }
                }
            } catch {
                completion(nil, .forecastDataNotAvailable)
            }
        }.resume()
    }
}
