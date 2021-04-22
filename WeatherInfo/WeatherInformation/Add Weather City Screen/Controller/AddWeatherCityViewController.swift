//
//  AddWeatherCityViewController.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 13/04/21.
//

import UIKit

protocol AddMoreCityViewControllerProtocol {
    func didNewCityAddedSuccessfully(_ cityName: String, _ cityId: Int64)
}

class AddMoreCityViewController: UIViewController {
    
    private var dbManager = DBManager()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    private var pendingRequestWorkItem: DispatchWorkItem?
    var viewModel = AddMoreCityViewModel()
    var delegate: AddMoreCityViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNib()
        searchBar.delegate = self
        viewModel.delegate = self
        viewModel.fetchAllSavedCities()
        self.configureNavigationBar()
    }
    
    // Method ton register nib (Cell)
    func registerNib() {
        self.tableView.register(UINib(nibName: "CityInformationTableViewCell", bundle: nil), forCellReuseIdentifier: CityInformationTableViewCell.reuseIdentifier)
    }
    
    // Method to configure Navigation Bar
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
    }
}

// MARK: UITableViewDelegate and UITableViewDataSource
extension AddMoreCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityInformationTableViewCell.reuseIdentifier, for: indexPath) as! CityInformationTableViewCell
        cell.configureData(viewModel.itemAt(indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        // Update the visibility status of selected city
        dbManager.updateVisibilityStatus(viewModel.itemAt(indexPath.row), true)
        if let delegate = self.delegate {
            let cityName = viewModel.itemAt(indexPath.row).cityName
            delegate.didNewCityAddedSuccessfully(cityName, viewModel.itemAt(indexPath.row).id)
        }
        // Go to Home Page and refresh data
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: UISearchBarDelegate
extension AddMoreCityViewController: UISearchBarDelegate {
    
    internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Cancel the currently pending item
        self.pendingRequestWorkItem?.cancel()
        
        // Wrap our request in a work item
        let requestWorkItem = DispatchWorkItem { [weak self] in
            guard let `self` = self else { return }
            self.viewModel.fetchSearchedCity(searchText)
        }
        
        // Save the new work item and execute it after 250 ms
        pendingRequestWorkItem = requestWorkItem
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250),
                                      execute: requestWorkItem)
    }
}

// MARK: AddMoreCityViewModelProtocol
extension AddMoreCityViewController: AddMoreCityViewModelProtocol {
    func fetchedDataSuccessfully() {
        // Update UI
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
