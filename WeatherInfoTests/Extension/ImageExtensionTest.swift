//
//  ImageExtensionTest.swift
//  WeatherInfoTests
//
//  Created by Hemant Soni on 23/04/21.
//

import XCTest
@testable import WeatherInfo

class ImageExtensionTest: XCTestCase {
    
    func testGetImageFromURL() {
        let sampleImageURL = "https://openweathermap.org//img/wn/10d@2x.png"
        let sampleImage = UIImageView()
        sampleImage.loadImageFromURL(url: sampleImageURL)
        
        let exp = expectation(description: "Test after 5 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(sampleImage.image, "Sample image must have image")
        } else {
            XCTFail("Delay interrupted")
        }
    }
}
