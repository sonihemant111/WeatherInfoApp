//
//  MockSession.swift
//  WeatherInfoTests
//
//  Created by Hemant Soni on 20/04/21.
//

import Foundation

class URLProtocolMock: URLProtocol {
    
    static var httpError:Error?
    static var testURLs = [URL?: String]()
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    static func clearMock(){
        testURLs.removeAll()
    }
    
    override func startLoading() {
        if let url = request.url {
            if let error = URLProtocolMock.httpError {
                self.client?.urlProtocol(self, didFailWithError: error)
                    return
            }
            print(url)
            print(URLProtocolMock.testURLs[url])
//            if let fileName = "WeatherData" {
                let bundle = Bundle(for: type(of: self))
                let urlPath = bundle.path(forResource: "WeatherData", ofType: "json")
                guard let path = urlPath else { return }
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path))
                    self.client?.urlProtocol(self, didLoad: data)
                } catch let err {
                    self.client?.urlProtocol(self, didFailWithError: err)
                }
//            }
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    override func stopLoading() { }
}
