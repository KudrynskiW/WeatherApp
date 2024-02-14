//
//  City.swift
//  WeatherApp
//
//  Created by Wojciech Kudrynski on 09/02/2024.
//

import Foundation

struct City: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String
}

extension City: Equatable, Hashable {
    static func ==(lhs: City, rhs: City) -> Bool {
        return lhs.name == rhs.name &&
        lhs.country == rhs.country &&
        lhs.state == rhs.state
    }
}
