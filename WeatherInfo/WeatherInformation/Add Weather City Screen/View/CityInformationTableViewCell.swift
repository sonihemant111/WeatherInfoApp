//
//  CityInformationTableViewCell.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 17/04/21.
//

import UIKit

class CityInformationTableViewCell: UITableViewCell {

    static var reuseIdentifier: String = "CityInformationTableViewCell"
    @IBOutlet weak var cityNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Method to configure cell and display the data
    func configureData(_ cityModel: CityModel) {
        cityNameLabel.text = cityModel.cityName + ", " + cityModel.countryName
    }
}
