//
//  SettingsViewController.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 17/04/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var viewModel = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNib()
        self.viewModel.configureSettingsData()
        self.tableView.reloadData()
        self.configureNavigationBar()
    }
    
    // Method to configure Navigation Bar
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .white
    }
    
    // Method ton register nib (Cell)
    func registerNib() {
        self.tableView.register(UINib(nibName: "SettingsCustomTableViewCell", bundle: nil), forCellReuseIdentifier: SettingsCustomTableViewCell.reuseIdentifier)
    }
}

// MARK: UITableViewDelegate and UITableViewDataSource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCustomTableViewCell.reuseIdentifier, for: indexPath) as! SettingsCustomTableViewCell
        cell.configureData(viewModel.itemAt(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        viewModel.saveNewUserSettings(indexPath.row)
        self.tableView.reloadData()
    }
}
