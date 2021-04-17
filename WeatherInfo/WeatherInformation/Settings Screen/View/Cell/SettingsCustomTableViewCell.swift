//
//  SettingsCustomTableViewCell.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 17/04/21.
//

import UIKit

class SettingsCustomTableViewCell: UITableViewCell {

    static var reuseIdentifier: String = "SettingsCustomTableViewCell"
    
    @IBOutlet weak var temperatureUnitLabel: UILabel!
    @IBOutlet weak var checkUncheckImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Method to configure data
    func configureData(_ settingsModel: SettingsModel) {
        self.checkUncheckImage.isHidden = true
        self.temperatureUnitLabel.text = settingsModel.tempUnit
        if settingsModel.isSelected {
            self.checkUncheckImage.isHidden = false
        }
    }
}
