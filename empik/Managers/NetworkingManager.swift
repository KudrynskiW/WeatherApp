//
//  NetworkingManager.swift
//  empik
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
            AF.request("https://api.openweathermap.org/geo/1.0/direct?q=\(cityString)&limit=5&appid=\(apiKey)").responseData { response in
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
            AF.request("https://api.openweathermap.org/data/2.5/forecast?lat=\(cityLat)&lon=\(cityLong)&units=metric&appid=\(apiKey)").responseData { response in
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

