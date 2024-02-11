//
//  ForecastCity.swift
//  empik
//
//  Created by Wojciech Kudrynski on 10/02/2024.
//

struct ForecastCity: Codable {
    /// City id.
    let id: Int
    
    /// City name.
    let name: String
    
    /// City coords.
    let coord: ForecastCityCoordinates
    
    /// Country code (GB, JP etc.).
    let country: String
    
    /// City population.
    let population: Int
    
    /// Shift in seconds from UTC.
    let timezone: Int
    
    /// Sunrise time, unix, UTC.
    let sunrise: Int
    
    /// Sunset time, unix, UTC.
    let sunset: Int
}
