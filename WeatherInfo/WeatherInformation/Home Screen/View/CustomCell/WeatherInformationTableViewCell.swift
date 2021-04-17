//
//  WeatherInformationTableViewCell.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 13/04/21.
//

import UIKit

class WeatherInformationTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String = "WeatherInformationTableViewCell"
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    @IBOutlet weak var refreshButton: UIButton!
    
    var didTapOnRefreshButton: ((_ indexPath: IndexPath) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // Method to configure cell
    func configureCell(_ weatherViewModel: WeatherViewModel) {
        cityNameLabel.text = weatherViewModel.cityName
        temperatureLabel.text = weatherViewModel.temperature

        // Show/Hide refresh button
        if weatherViewModel.isRefreshNeeded {
            loaderView.stopAnimating()
            loaderView.isHidden = true
            temperatureLabel.isHidden = true
            refreshButton.isHidden = false
        } else {
            refreshButton.isHidden = true
            if weatherViewModel.temperature.isEmpty {
                loaderView.startAnimating()
                loaderView.isHidden = false
                temperatureLabel.isHidden = true
            } else {
                loaderView.stopAnimating()
                loaderView.isHidden = true
                temperatureLabel.isHidden = false
            }
        }
    }
    
    // MARK: UIButton Action
    @IBAction func refreshButtonAction(_ sender: UIButton) {
        guard let closure = self.didTapOnRefreshButton else { return }
        if let indexPath = self.indexPath {
            // Show Loader
            loaderView.isHidden = false
            refreshButton.isHidden = true
            loaderView.startAnimating()
            closure(indexPath)
        }
    }
}
