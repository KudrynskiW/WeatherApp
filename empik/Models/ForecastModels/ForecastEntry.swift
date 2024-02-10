//
//  ForecastEntry.swift
//  empik
//
//  Created by Wojciech Kudrynski on 10/02/2024.
//

struct ForecastEntry: Codable {
    let dt: Int
    let main: TemperatureDetails
    let weather: WeatherDetails
    let clouds: CloudsDetails
    let wind: WindDetails
    let visibility: Int
    let pop: Int
    let sys: SysDetails // co to jest?
    let dt_txt: String
}
