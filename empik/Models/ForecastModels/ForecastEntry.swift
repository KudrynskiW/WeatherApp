//
//  ForecastEntry.swift
//  empik
//
//  Created by Wojciech Kudrynski on 10/02/2024.
//

struct ForecastEntry: Codable {
    /// Time of data forecasted, unix, UTC.
    let dt: Int
    
    /// Details about temperature.
    let main: TemperatureDetails
    
    /// Details about weather.
    let weather: [WeatherDetails]
    
    /// Details about clouds.
    let clouds: CloudsDetails
    
    /// Details about wind.
    let wind: WindDetails
    
    /// Average visibility, metres. The maximum value of the visibility is 10km.
    let visibility: Int
    
    /// Probability of precipitation. The values of the parameter vary between 0 and 1, where 0 is equal to 0%, 1 is equal to 100%.
    let pop: Float
    
    /// Day or night.
    let sys: SysDetails
    
    /// Time of data forecasted, ISO, UTC.
    let dt_txt: String
}
