//
//  ExtensionUserdefaults.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 17/04/21.
//

import Foundation

enum UserDefaultsKeys: String {
    case SavedTempUnit
}

// Extension of UserDefaults
extension UserDefaults {
    // Generic method to set object
    func setCodableObject<T: Codable>(_ data: T?, forKey defaultName: String) {
      let encoded = try? JSONEncoder().encode(data)
      set(encoded, forKey: defaultName)
    }
    
    // Generic method to get object
    func codableObject<T : Codable>(dataType: T.Type, key: String) -> T? {
        guard let userDefaultData = data(forKey: key) else {
          return nil
        }
        return try? JSONDecoder().decode(T.self, from: userDefaultData)
      }
    
    // Method to save user settings
    func saveUserSettings(_ settingsModel: SettingsModel) {
        self.setCodableObject(settingsModel, forKey: UserDefaultsKeys.SavedTempUnit.rawValue)
    }
    
    // Method to retrive saved user settings
    func getUserSavedSettings() -> SettingsModel? {
        return self.codableObject(dataType: SettingsModel.self, key: UserDefaultsKeys.SavedTempUnit.rawValue)
    }
    
    // Method to save default user Settings
    func saveDefaultUserSettings() {
        if self.getUserSavedSettings() == nil {
            // prepare default settings model
            let fahrenheitSettingsModel = SettingsModel()
            fahrenheitSettingsModel.tempUnit = "fahrenheit"
            fahrenheitSettingsModel.isSelected = true
            self.saveUserSettings(fahrenheitSettingsModel)
        }
    }
}
