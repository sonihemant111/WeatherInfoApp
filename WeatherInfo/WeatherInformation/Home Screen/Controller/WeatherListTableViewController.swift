//
//  WeatherInformationTableViewController.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 13/04/21.
//

import UIKit
import Foundation
import Toast_Swift

class WeatherListTableViewController: UITableViewController {
    
    private var weatherListViewModel = WeatherListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNib()
        self.configureNavigationBar()
        self.checkInternetConnection()
        self.weatherListViewModel.updateUI = { [weak self] (indexPath) in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.tableView.beginUpdates()
                self.tableView.reloadRows(at: [indexPath], with: .fade)
                self.tableView.endUpdates()
            }
        }
        
        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.weatherListViewModel.addNewCity("Jodhpur")
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath(row: self.weatherListViewModel.numberOfRows(0) - 1, section: 0)], with: .automatic)
            self.tableView.endUpdates()
        }*/
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func addWeatherDidSave(_ weatherViewModel: WeatherViewModel) {
        self.weatherListViewModel.addWeatherViewModel(weatherViewModel)
        self.tableView.reloadData()
    }
    
    // Method to register Nib
    func registerNib() {
        self.tableView.register(UINib(nibName: "WeatherInformationTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherInformationTableViewCell")
    }
    
    // check Internet connection
    func checkInternetConnection() {
        if !AppNetworking.isConnected() {
            // Show a Toast message
            self.view.makeToast(StringConstants.noInternetConnectionMessage, duration: 1.0, position: .center)

        }
    }
    
    // Method to configure Navigation Bar
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .purple
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return weatherListViewModel.numberOfSection()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel.numberOfRows(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherInformationTableViewCell", for: indexPath) as! WeatherInformationTableViewCell
        // fetching weather view model at specific index to display the weather data
        let weatherViewModel = weatherListViewModel.modelAt(indexPath.row)
        cell.configureCell(weatherViewModel)
        cell.didTapOnRefreshButton = { (indexPath) in
            // call API again to fetch weather data
            weatherViewModel.getWeatherData()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
