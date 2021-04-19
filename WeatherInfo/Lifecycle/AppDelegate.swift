//
//  AppDelegate.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 13/04/21.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let dbManager = DBManager()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DBManager.printRealmFileUrl()
        // set default user settings if user has not set any yet
        UserDefaults.standard.saveDefaultUserSettings()
        if !dbManager.checkIsAllCitiesDataAlreadySaved() {
            self.fetchCityDataFromJSON()
        }
        dbManager.setDefaultCity()
        return true
    }
    
    // Method to parse city json and save in realm DB
    func fetchCityDataFromJSON() {
        if let path = Bundle.main.path(forResource: "cityList", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                if let cities = try? JSONDecoder().decode(List<CityModel>.self, from: data) {
                    dbManager.saveCities(cities)
                }
            } catch {
                // handle error
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}


