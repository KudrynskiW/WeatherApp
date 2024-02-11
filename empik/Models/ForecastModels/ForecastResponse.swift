//
//  ForecastResponse.swift
//  empik
//
//  Created by Wojciech Kudrynski on 10/02/2024.
//

struct ForecastResponse: Codable {
    ///  Internal API parameter.
    private let cod: String
    
    ///  Internal API parameter.
    private let message: Int
    
    /// A number of timestamps returned in the API response.
    private let cnt: Int
    
    /// List of data forecasted.
    let list: [ForecastEntry]
    
    /// City of forecast.
    let city: ForecastCity
}
