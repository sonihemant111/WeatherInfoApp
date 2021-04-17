//
//  Extensions.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 15/04/21.
//

import UIKit

// Extension of UITableViewCell
extension UITableViewCell {
    var tableView: UITableView? {
        return self.next(of: UITableView.self)
    }

    var indexPath: IndexPath? {
        return self.tableView?.indexPath(for: self)
    }
}


