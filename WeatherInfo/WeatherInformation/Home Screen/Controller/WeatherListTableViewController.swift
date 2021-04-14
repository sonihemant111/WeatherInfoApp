//
//  WeatherInformationTableViewController.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 13/04/21.
//

import UIKit
import Foundation

class WeatherListTableViewController: UITableViewController {
    
    var viewModel = WeatherListViewModel()
    var arrCities = [WeatherData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNib()
        self.configureNavigationBar()
        
        // Add initially three cities
        // Sydney, Melbourne and Brisbane
        var weatherOfSydney = WeatherData()
        weatherOfSydney.name = "Sydney"
        arrCities.append(weatherOfSydney)
        
        var weatherOfMelbourne = WeatherData()
        weatherOfMelbourne.name = "Melbourne"
        arrCities.append(weatherOfMelbourne)
        
        var weatherOfBrisbane = WeatherData()
        weatherOfBrisbane.name = "Brisbane"
        arrCities.append(weatherOfBrisbane)
        
        viewModel.updateUI = { [weak self] (weatherData) in
            guard let self = self else { return }
            // filter array with city name and update that city's weather data
            if let row = self.arrCities.firstIndex(where: {$0.name == weatherData.name}) {
                self.arrCities[row] = weatherData
            }
            self.tableView.reloadData()
        }
        viewModel.getWeatherData(cityName: "Sydney", scale: .fahrenheit)
        viewModel.getWeatherData(cityName: "Melbourne", scale: .fahrenheit)
        viewModel.getWeatherData(cityName: "Brisbane", scale: .fahrenheit)
    }
    
    // Method to register Nib
    func registerNib() {
        self.tableView.register(UINib(nibName: "WeatherInformationTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherInformationTableViewCell")
    }
    
    // Method to configure Navigation Bar
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .purple
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrCities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherInformationTableViewCell", for: indexPath) as! WeatherInformationTableViewCell
        cell.configureCell(arrCities[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
