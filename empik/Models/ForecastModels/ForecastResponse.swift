//
//  ForecastResponse.swift
//  empik
//
//  Created by Wojciech Kudrynski on 10/02/2024.
//

struct ForecastResponse: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [ForecastEntry]
    let city: ForecastCity
}
