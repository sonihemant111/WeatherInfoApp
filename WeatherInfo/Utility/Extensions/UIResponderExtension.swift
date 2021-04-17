//
//  UIResponderExtension.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 17/04/21.
//

import Foundation
import UIKit

// Extension of UIResponder
extension UIResponder {
    /**
     * Returns the next responder in the responder chain cast to the given type, or
     * if nil, recurses the chain until the next responder is nil or castable.
     */
    func next<U: UIResponder>(of type: U.Type = U.self) -> U? {
        return self.next.flatMap({ $0 as? U ?? $0.next() })
    }
}
