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
    private var dbManager = DBManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNib()
        self.weatherListViewModel.delegate = self
        self.configureRefreshController()
        self.checkInternetConnection()
        // Method to call API periodically
        Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(refreshWeatherData), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationBar()
    }
        
    // Method to refresh weather data
    @objc func refreshWeatherData() {
        self.refreshControl?.endRefreshing()
        // check internet connection first
        if !self.checkInternetConnection() {
            return
        }
        
        if weatherListViewModel.numberOfRows(0) > 0 {
            self.weatherListViewModel.refreshTemperatureData()
        }
        self.tableView.reloadData()
    }
    
    // Method to setup Refresh controller
    func configureRefreshController() {
        let refreshController = UIRefreshControl()
        refreshController.tintColor = .white
        self.refreshControl = refreshController
        self.refreshControl?.addTarget(self, action: #selector(refreshWeatherData), for: .valueChanged)
    }
        
    // Method to register Nib
    func registerNib() {
        self.tableView.register(UINib(nibName: "WeatherInformationTableViewCell", bundle: nil), forCellReuseIdentifier: WeatherInformationTableViewCell.reuseIdentifier)
    }
    
    // Method to redirect user to weatherDetail screen
    @objc func redirectToAddMoreCityScreen() {
        let addMoreCityVC: AddMoreCityViewController = self.storyboard?.instantiateViewController(withIdentifier: "AddMoreCityViewController") as! AddMoreCityViewController
        addMoreCityVC.delegate = self
        self.navigationController?.pushViewController(addMoreCityVC, animated: true)
    }
    
    // Method to redirect user to settimgs screen
    @objc func redirectToSettingsScreen() {
        let settingsVC: SettingsViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        settingsVC.delegate = self
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    // check Internet connection
    @discardableResult
    func checkInternetConnection(showToast: Bool = true) -> Bool {
        if !AppNetworking.isConnected() {
            if showToast {
                self.view.makeToast(StringConstants.noInternetConnectionMessage, duration: 1.0, position: .center)
            }
            return false
        } else {
            return true
        }
    }
    
    // Show toast message
    func showToast(_ message: String) {
        // Show a Toast message
        self.view.makeToast(message, duration: 1.0, position: .center)
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
        
        // set Right navigation bar button action
        self.navigationItem.rightBarButtonItem?.target = self
        self.navigationItem.rightBarButtonItem?.action = #selector(redirectToAddMoreCityScreen)
        
        // set Left navigation bar button action
        self.navigationItem.leftBarButtonItem?.target = self
        self.navigationItem.leftBarButtonItem?.action = #selector(redirectToSettingsScreen)
    }
    
    // Method to show alert
    func showAlert(_ indexPath: IndexPath) {
        let alert = UIAlertController(title: "Alert", message: StringConstants.removeCityWarningMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { action in
            // Update visibility status in DB
            let weatherViewModel = self.weatherListViewModel.itemAt(indexPath.row)
            self.dbManager.updateVisibilityStatusByCityID(weatherViewModel.cityID, false)
            self.weatherListViewModel.removeItemAt(indexPath.row)
            self.refreshWeatherData()
        }))
        
        alert.addAction(UIAlertAction(title: "NO", style: .default, handler: { action in
            // do nothing
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return weatherListViewModel.numberOfSection()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel.numberOfRows(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherInformationTableViewCell.reuseIdentifier, for: indexPath) as! WeatherInformationTableViewCell
        // fetching weather view model at specific index to display the weather data
        let weatherViewModel = weatherListViewModel.itemAt(indexPath.row)
        cell.configureCell(weatherViewModel)
        cell.didTapOnRefreshButton = { (indexPath) in
            // check internet connection before calling API
            if self.checkInternetConnection() {
                // call API again to fetch weather data
                weatherViewModel.getWeatherData()
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Redirect user to weather detail screen
        self.redirectToWeatherDetailScreen(indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // Method to redirect user to weatherDetail screen
    func redirectToWeatherDetailScreen(_ indexPath: IndexPath) {
        let weatherDetailVC: WeatherDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "WeatherDetailViewController") as! WeatherDetailViewController
        let weatherModel = self.weatherListViewModel.itemAt(indexPath.row)
        weatherDetailVC.currentSelectedWeatherViewModel = weatherModel
        self.navigationController?.pushViewController(weatherDetailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") {  [weak self] (contextualAction, view, boolValue) in
            guard let `self` = self else { return }
            self.showAlert(indexPath)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        return swipeActions
    }
}

// MARK: WeatherListViewModelProtocol
extension WeatherListTableViewController: WeatherListViewModelProtocol {
    func didReceiveWeatherDetailsAt(_ indexPath: IndexPath) {
        // Update UI
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: AddMoreCityViewControllerProtocol
extension WeatherListTableViewController: AddMoreCityViewControllerProtocol {
    func didNewCityAddedSuccessfully(_ cityName: String, _ cityId: Int64) {
        self.weatherListViewModel.addNewCity(cityName, cityId)
    }
}

// MARK: AddMoreCityViewControllerProtocol
extension WeatherListTableViewController: SettingsViewControllerProtocol {
    func didUpdateUserSettings() {
        self.weatherListViewModel.refreshTemperatureData()
    }
}
