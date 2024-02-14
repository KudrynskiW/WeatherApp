//
//  StorageManager.swift
//  WeatherApp
//
//  Created by Wojciech Kudrynski on 13/02/2024.
//

import Foundation

protocol StorageManagerProtocol {
    func saveCity(city: City)
    func loadCities() -> [City]
}

class StorageManager {
    private enum Constants {
        static let storageKey = "SavedCities"
    }
    
    let storage = UserDefaults.standard
    static let shared = StorageManager()
    
    init() { }
    
    private func encodeCityToData(city: City) -> Data? {
        let encoder = JSONEncoder()
        
        let cityEncoded = try? encoder.encode(city)
        return cityEncoded
    }
    
    private func encodeCityToArrayAndData(baseArray: [City], cityToEncode: City) -> [Data?] {
        var loadedCities = baseArray
        var encodedCities: [Data?] = []
        loadedCities.removeAll(where: { $0 == cityToEncode })
        loadedCities.append(cityToEncode)
        loadedCities.forEach { city in
            encodedCities.append(encodeCityToData(city: city))
        }
        
        return encodedCities
    }
}

extension StorageManager: StorageManagerProtocol {
    func saveCity(city: City) {
        if let cities = storage.array(forKey: Constants.storageKey), !cities.isEmpty {
            let loadedCities = loadCities()
            let encodedCities = encodeCityToArrayAndData(baseArray: loadedCities, cityToEncode: city)
            
            storage.set(encodedCities, forKey: Constants.storageKey)
        } else {
            if let cityEncoded = encodeCityToData(city: city) {
                storage.set([cityEncoded], forKey: Constants.storageKey)
            }
        }
    }
    
    func loadCities() -> [City] {
        if let cities = storage.array(forKey: Constants.storageKey) {
            var citiesDecodedArray: [City?] = []
            cities.forEach { city in
                if let city = city as? Data {
                    let cityDecoded = try? JSONDecoder().decode(City.self, from: city)
                    citiesDecodedArray.append(cityDecoded)
                }
            }
            
            return citiesDecodedArray.compactMap({ $0 })
        } else {
            return []
        }
    }
}
