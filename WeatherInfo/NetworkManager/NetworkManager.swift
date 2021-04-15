//
//  NetworkManager.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 14/04/21.
//

import Foundation

enum AppNetworking {
    static func isConnected() -> Bool {
        do {
            return try Reachability().connection != .unavailable
        } catch {
            return false
        }
    }
}

class NetworkManager {
    public static let main = NetworkManager()
    private init() {}
    private var session = URLSession(configuration: URLSessionConfiguration.default)
    
    /// this method will handle POST request
    /// - Parameters:
    ///   - url: URL
    ///   - params: params
    ///   - file: if there is any file to be uploaded
    ///   - fileType: mem type
    ///   - completion: completion
    func requestToServer(request: URLRequest, completion:@escaping(_ data: Data?, _ responce: URLResponse?, _ error: Error?) -> Void){
        
        let task = session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
    }
    
    func setMockSession(session: URLSession) {
        self.session = session
    }
}
