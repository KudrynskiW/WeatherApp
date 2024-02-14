//
//  NetworkingManager.swift
//  WeatherApp
//
//  Created by Wojciech Kudrynski on 09/02/2024.
//

import Foundation
import Alamofire

protocol NetworkingManagerProtocol {
    func fetchWeatherCities(cityString: String) async throws -> [City]
    func fetchWeatherDetailsForCity(cityLat: Double, cityLong: Double) async throws -> ForecastResponse
}

enum NetworkingManagerError: Error {
    case wrongAPIKey
    case decodingError
    case wrongResponse(String)
}

class NetworkingManager: NetworkingManagerProtocol {
    private enum Constants {
        enum Parameters {
            static let cityString = "q"
            static let cityListingLimit = "limit"
            static let appId = "appId"
            static let units = "units"
            static let latitude = "lat"
            static let longitude = "lon"
        }
        
        static let unitsParameterValue = "metric"
        static let cityListingLimitParameterValue = 5
        static let baseURLString = "https://api.openweathermap.org"
    }
    
    static let shared = NetworkingManager()
    var apiKey: String?
    
    init() {
        loadAPIKey()
    }
    
    func loadAPIKey() {
        if let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") {
            let plist = NSDictionary(contentsOfFile: filePath)
            apiKey = plist?.object(forKey: "API_KEY") as? String
        }
    }
    
    func fetchWeatherCities(cityString: String) async throws -> [City] {
        guard let apiKey else { throw NetworkingManagerError.wrongAPIKey }
        
        return try await withCheckedThrowingContinuation { continuation in
            let parameters: Parameters = [
                Constants.Parameters.cityString: cityString,
                Constants.Parameters.cityListingLimit: Constants.cityListingLimitParameterValue,
                Constants.Parameters.appId: apiKey,
            ]
            
            AF.request(Constants.baseURLString + "/geo/1.0/direct", parameters: parameters).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode([City].self, from: data)
                        continuation.resume(with: .success(decodedData))
                    } catch {
                        continuation.resume(throwing: NetworkingManagerError.decodingError)
                    }
                case .failure(let err):
                    continuation.resume(throwing: NetworkingManagerError.wrongResponse(err.localizedDescription))
                }
            }
        }
    }
    
    func fetchWeatherDetailsForCity(cityLat: Double, cityLong: Double) async throws -> ForecastResponse {
        guard let apiKey else { throw NetworkingManagerError.wrongAPIKey }
        
        return try await withCheckedThrowingContinuation { continuation in
            let parameters: Parameters = [
                Constants.Parameters.latitude: cityLat,
                Constants.Parameters.longitude: cityLong,
                Constants.Parameters.units: Constants.unitsParameterValue,
                Constants.Parameters.appId: apiKey,
            ]
            
            AF.request(Constants.baseURLString + "/data/2.5/forecast", parameters: parameters).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedData = try JSONDecoder().decode(ForecastResponse.self, from: data)
                        continuation.resume(with: .success(decodedData))
                    } catch {
                        print(error.localizedDescription)
                        continuation.resume(throwing: NetworkingManagerError.decodingError)
                    }
                case .failure(let err):
                    continuation.resume(throwing: NetworkingManagerError.wrongResponse(err.localizedDescription))
                }
            }
        }
    }
}

