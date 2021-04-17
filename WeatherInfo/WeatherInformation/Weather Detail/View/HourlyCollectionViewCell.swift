//
//  HourlyCollectionViewCell.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 16/04/21.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier: String = "HourlyCollectionViewCell"
    
    @IBOutlet weak var hourlyTimeLabel: UILabel!
    @IBOutlet weak var temperatureSymbol: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // Method to configure Cell's Data
    func configure(with item: WeatherInfo) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        if let date = dateFormatterGet.date(from: item.time) {
            hourlyTimeLabel.text = dateFormatter.string(from: date)
        }
        
        temperatureSymbol.loadImageFromURL(url: URLManager.init().fetchIconImage + "\(item.icon)@2x.png")
        temperatureLabel.text = String(item.temp.kelvinToCeliusConverter())
    }

}
