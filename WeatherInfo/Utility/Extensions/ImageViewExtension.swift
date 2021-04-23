//
//  ImageViewExtension.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 17/04/21.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
let cachedImages = NSCache<NSString, UIImage>()

// Extension of UIImageView
extension UIImageView {
    func loadImageFromURL(url: String) {
        self.image = nil
        guard let URL = URL(string: url) else {
            print("No Image For this url", url)
            return
        }
        
        if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL) {
                if let image = UIImage(data: data) {
                    let imageTocache = image
                    imageCache.setObject(imageTocache, forKey: url as AnyObject)
                    
                    DispatchQueue.main.async {
                        self?.image = imageTocache
                    }
                }
            }
        }
        
    }
}


extension Int {
    func incrementWeekDays(by num: Int) -> Int {
        let incrementedVal = self + num
        let mod = incrementedVal % 7
        
        return mod
    }
}
