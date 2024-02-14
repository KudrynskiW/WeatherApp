//
//  SysDetails.swift
//  WeatherApp
//
//  Created by Wojciech Kudrynski on 10/02/2024.
//

struct SysDetails: Codable {
    enum PartOfDay: String, Codable {
        case night = "n"
        case day = "d"
    }
    /// Part of the day (n - night, d - day).
    let pod: PartOfDay
}
