//
//  TemperatureDetails.swift
//  WeatherApp
//
//  Created by Wojciech Kudrynski on 10/02/2024.
//

struct TemperatureDetails: Codable {
    /// Temperature.
    let temp: Float
    
    /// Temperature. This temperature parameter accounts for the human perception of weather.
    let feels_like: Float
    
    /// Minimum temperature at the moment. This is minimal currently observed temperature (within large megalopolises and urban areas).
    let temp_min: Float
    
    /// Maximum temperature at the moment. This is maximal currently observed temperature (within large megalopolises and urban areas).
    let temp_max: Float
    
    /// Atmospheric pressure on the sea level, hPa.
    let pressure: Int
    
    /// Atmospheric pressure on the sea level, hPa.
    let sea_level: Int
    
    ///  Atmospheric pressure on the ground level, hPa.
    let grnd_level: Int
    
    /// Humidity, %.
    let humidity: Int
}
