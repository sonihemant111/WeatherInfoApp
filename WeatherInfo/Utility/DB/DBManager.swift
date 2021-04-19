//
//  DBManager.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 18/04/21.
//

import Foundation
import RealmSwift

class DBManager {
        
    // Method to print file URL
    static func printRealmFileUrl()  {
        do {
            let localRealm = try Realm()
            print(localRealm.configuration.fileURL as Any)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Method to save vcity Data
    func saveCities(_ cities: List<CityModel>) {
        do {
            let localRealm = try Realm()
            localRealm.beginWrite()
            localRealm.add(cities)
            try localRealm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Method to show (Set isVisible = true) three cities (sydney, melbourne, brisbane) by default
    func setDefaultCity() {
        do {
            let localRealm = try Realm()
            let sydney = localRealm.objects(CityModel.self).filter("id=4163971").last
            let melbourne = localRealm.objects(CityModel.self).filter("id=2147714").last
            let brisbane = localRealm.objects(CityModel.self).filter("id=2174003").last
            
            localRealm.beginWrite()
            sydney?.isVisible = true
            melbourne?.isVisible = true
            brisbane?.isVisible = true
            try localRealm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Method to delete all data in DB
    func deleteAll() {
        do {
            let localRealm = try Realm()
            localRealm.beginWrite()
            localRealm.deleteAll()
            try localRealm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Method to check is city data is already saved or not
    func checkIsAllCitiesDataAlreadySaved() -> Bool {
        do {
            let localRealm = try Realm()
            let tasks = localRealm.objects(CityModel.self)
            return ((Array(tasks).count) > 0 ? true : false)
            
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    // Method to fetch cityData from realm DB
    func fetchCity(_ searchKeyword: String, completionHandler: @escaping ((Array<CityModel>) -> Void)) {
        do {
            let localRealm = try Realm()
            let tasks = localRealm.objects(CityModel.self)
            let predicate = NSPredicate(format: "(cityName CONTAINS[c] %@)", searchKeyword)
            let cityList = tasks.filter(predicate)
            completionHandler(Array(cityList))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Method to fetch all cities
    func fetchAllCities(_ completionHandler: @escaping ((Array<CityModel>) -> Void)) {
        do {
            let localRealm = try Realm()
            let tasks = localRealm.objects(CityModel.self)
            completionHandler(Array(tasks))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Method to fetch all selected cities
    func fetchAllSelectedCities() -> [(String,Int64)] {
        do {
            let localRealm = try Realm()
            let tasks = localRealm.objects(CityModel.self)
            let predicate = NSPredicate(format: "isVisible=true")
            let selectedCityList = tasks.filter(predicate)
            var arrCity = [(String,Int64)]()
            if selectedCityList.count > 0 {
                for i in 0...selectedCityList.count - 1 {
                    let cityData = (cityName: selectedCityList[i].cityName, cityID: selectedCityList[i].id)
                    arrCity.append(cityData)
                }
            }
            
            return arrCity
        } catch {
            print(error.localizedDescription)
        }
        return [("", 0)]
    }
    
    // Method to update the city data
    func updateVisibilityStatus(_ cityData: CityModel, _ visibilityStatus: Bool) {
        do {
            let localRealm = try Realm()
            localRealm.beginWrite()
            cityData.isVisible = visibilityStatus
            try localRealm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Method to update the city data
    func updateVisibilityStatusByCityID(_ cityID: Int64,_ visibilityStatus: Bool) {
        do {
            let localRealm = try Realm()
            let tasks = localRealm.objects(CityModel.self)
            let predicate = NSPredicate(format: "id = %d", cityID)
            let desiredCity = tasks.filter(predicate)
            localRealm.beginWrite()
            desiredCity.first?.isVisible = visibilityStatus
            try localRealm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
}
