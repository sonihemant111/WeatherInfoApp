//
//  RequestManager.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 14/04/21.
//

import Foundation

class RequestManager {
    typealias completion = (_ responce: Data?, _ error: Error?) -> Void
    
    /// get request
    /// - Parameters:
    ///   - url: url
    ///   - completion: completion
    func get(with url: URL, completion: @escaping completion) {
        var request = self.getRequest(url, "GET")
        request.timeoutInterval = 30
        NetworkManager.main.requestToServer(request: request) { (data, request, error) in
            if let data = data {
                let str = String(decoding: Data(data), as: UTF8.self)
                if let data = str.data(using: String.Encoding.utf8 ) {
                    completion(data, nil)
                }else{
                    let error = NSError(domain: url.path, code: 5001, userInfo: ["message":"Unknown Error occurred"]) as Error
                    completion(nil, error)
                }
            } else {
                completion(nil, error)
                
            }
        }
    }
    
    ///  will return requent object
    /// - Parameters:
    ///   - url: URL
    ///   - method: request type
    ///   - body: param
    private func getRequest(_ url: URL, _ method: String, _ body: Data? = nil) -> URLRequest {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let _body = body {
            request.httpBody = _body
        }
        return request as URLRequest
    }
}
