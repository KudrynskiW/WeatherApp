//
//  ForecastCity.swift
//  empik
//
//  Created by Wojciech Kudrynski on 10/02/2024.
//

struct ForecastCity: Codable {
    let id: Int
    let name: String
    let coord: ForecastCityCoordinates
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}
