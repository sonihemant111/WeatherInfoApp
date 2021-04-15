//
//  WeatherInformationTableViewCell.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 13/04/21.
//

import UIKit

class WeatherInformationTableViewCell: UITableViewCell {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureCell(_ weatherViewModel: WeatherViewModel) {
        cityNameLabel.text = weatherViewModel.cityName
        temperatureLabel.text = weatherViewModel.temperature

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
