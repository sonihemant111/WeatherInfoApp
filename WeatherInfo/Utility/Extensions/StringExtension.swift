//
//  StringExtension.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 20/04/21.
//

import Foundation

extension String {
    // To remove special character from string
    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890")
        return self.filter {okayChars.contains($0) }
    }
}
