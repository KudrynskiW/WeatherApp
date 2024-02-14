//
//  WindDetails.swift
//  WeatherApp
//
//  Created by Wojciech Kudrynski on 10/02/2024.
//

struct WindDetails: Codable {
    /// Wind speed. Metric: meter/sec.
    let speed: Float
    
    /// Wind direction, degrees (meteorological).
    let deg: Int
    
    /// Wind gust. Metric: meter/sec.
    let gust: Float
}
