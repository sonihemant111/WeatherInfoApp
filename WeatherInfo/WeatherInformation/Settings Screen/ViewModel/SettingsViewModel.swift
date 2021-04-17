
//
//  SettingsViewModel.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 17/04/21.
//

import Foundation

class SettingsViewModel {
    
    var settingViewModels = [SettingsModel]()
    
    var numberOfRow: Int {
        return settingViewModels.count
    }
    
    // Method to configure data
    func configureSettingsData() {
        // check if user has already set the temp unit choice
        let settingsModel = UserDefaults.standard.getUserSavedSettings()
        
        // adding Fahrenheit
        let fahrenheitSettingsModel = SettingsModel()
        fahrenheitSettingsModel.tempUnit = StringConstants.fahrenheit
        if settingsModel?.tempUnit.lowercased() == fahrenheitSettingsModel.tempUnit {
            fahrenheitSettingsModel.isSelected = true
        }
        settingViewModels.append(fahrenheitSettingsModel)
        
        // adding Fahrenheit
        let celsiusSettingsModel = SettingsModel()
        celsiusSettingsModel.tempUnit = StringConstants.celsius
        if settingsModel?.tempUnit.lowercased() == celsiusSettingsModel.tempUnit {
            celsiusSettingsModel.isSelected = true
        }
        settingViewModels.append(celsiusSettingsModel)
    }

    // Method to get settings model at specific index
    func itemAt(index: Int) -> SettingsModel {
        let settingsModel: SettingsModel = settingViewModels[index]
        settingsModel.tempUnit = settingsModel.tempUnit.capitalized
        return settingsModel
    }
    
    // Method to save new user settings
    func saveNewUserSettings(_ index: Int) {
        // Get previously selected settings
        settingViewModels.filter({$0.isSelected == true}).first?.isSelected = false
        let settingsModel: SettingsModel = settingViewModels[index]
        settingsModel.isSelected = true
        UserDefaults.standard.saveUserSettings(settingsModel)
    }
}
