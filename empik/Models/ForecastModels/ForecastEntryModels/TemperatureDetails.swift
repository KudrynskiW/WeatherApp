//
//  TemperatureDetails.swift
//  empik
//
//  Created by Wojciech Kudrynski on 10/02/2024.
//

struct TemperatureDetails: Codable {
    let temp: Float
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float
    let pressure: Int
    let sea_level: Int
    let grnd_level: Int
    let humidity: Int
    let temp_kf: Float
}
