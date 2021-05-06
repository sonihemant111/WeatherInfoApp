//
//  CityModel.swift
//  WeatherInfo
//
//  Created by Hemant Soni on 17/04/21.
//

import Foundation
import RealmSwift

class CityModel: Object, Codable {
    @objc dynamic var id: Int64 = 0
    @objc dynamic var cityName: String = ""
    @objc dynamic var state: String = ""
    @objc dynamic var countryName: String = ""
    @objc dynamic var coordinate: Coordinate?
    @objc dynamic var isVisible: Bool = false
    
    private enum CodingKeys : String, CodingKey {
        case id, cityName = "name", countryName = "country", state, coordinate = "coord"
    }
    
    override init() {
        super.init()
    }
    
    public required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int64.self, forKey: .id)
        cityName = try container.decode(String.self, forKey: .cityName)
        state = try container.decode(String.self, forKey: .state)
        countryName = try container.decode(String.self, forKey: .countryName)
        coordinate = try container.decode(Coordinate.self, forKey: .coordinate)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(cityName, forKey: .cityName)
        try container.encode(state, forKey: .state)
        try container.encode(countryName, forKey: .countryName)
    }
}

class Coordinate: Object, Codable {
    @objc dynamic var lat: Double = 0.0
    @objc dynamic var long: Double = 0.0
    
    private enum CodingKeys : String, CodingKey {
        case lat, long = "lon"
    }
    
    override init() {
        super.init()
    }
    
    public required init(from decoder: Decoder) throws {
        super.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lat = try container.decode(Double.self, forKey: .lat)
        lat = try container.decode(Double.self, forKey: .long)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lat, forKey: .lat)
        try container.encode(long, forKey: .long)
    }
}
