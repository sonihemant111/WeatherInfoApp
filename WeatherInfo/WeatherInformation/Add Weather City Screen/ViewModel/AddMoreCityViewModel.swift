//
//  AddMoreCityViewModel.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 17/04/21.
//

import Foundation

protocol AddMoreCityViewModelProtocol {
    func fetchedDataSuccessfully()
}

class AddMoreCityViewModel {
    var dbManager = DBManager()
    var addMoreCityViewModels = [CityModel]()
    var delegate: AddMoreCityViewModelProtocol?
    
    // Method to fetch data from database
    func fetchSearchedCity(_ searchKeyword: String) {
        // check if user has cleared the search text then show all cities
        if searchKeyword.isEmpty {
            dbManager.fetchAllCities { [weak self] (citiesData) in
                guard let `self` = self, let delegate = self.delegate else {
                    return
                }
                self.addMoreCityViewModels = citiesData
                delegate.fetchedDataSuccessfully()
            }
        } else {
            dbManager.fetchCity(searchKeyword) { [weak self] (citiesData) in
                guard let `self` = self, let delegate = self.delegate else {
                    return
                }
                self.addMoreCityViewModels = citiesData
                delegate.fetchedDataSuccessfully()
            }
        }
    }
    
    // Method to fetch all cities from database
    func fetchAllSavedCities() {
        dbManager.fetchAllCities({ [weak self] (citiesData) in
            guard let `self` = self, let delegate = self.delegate else {
                return
            }
            self.addMoreCityViewModels = citiesData
            delegate.fetchedDataSuccessfully()
        })
    }
        
    // Return number of items in array
    var numberOfRow: Int {
        return addMoreCityViewModels.count
    }
    
    // Method to return item at specfic index
    func itemAt(_ index: Int) -> CityModel {
        let cityModel = addMoreCityViewModels[index]
        return cityModel
    }
}
