//
//  WeatherDetails.swift
//  WeatherApp
//
//  Created by Wojciech Kudrynski on 10/02/2024.
//

struct WeatherDetails: Codable {
    /// Group of weather parameters (Rain, Snow, Clouds etc.).
    let main: String
    
    /// Weather condition within the group.
    let description: String
    
    /// Weather icon id.
    let icon: String
}
