//
//  CitySearchViewModel.swift
//  empik
//
//  Created by Wojciech Kudrynski on 09/02/2024.
//

import Foundation
import RxSwift
import RxCocoa

protocol CitySearchViewModelProtocol {
    func fetchCities(cityString: String) async
    func getHistoryCities() -> [City]
    func navigateToForecastDetails(with city: City)
    
    var fetchedCities: Driver<[City]> { get }
    var fetchedCitiesError: Driver<String?> { get }
    
    var coordinator: ForecastCoordinatorProtocol { get }
}

final class CitySearchViewModel {
    private var fetchedCitiesSubject: BehaviorSubject<[City]> = .init(value: [])
    private var fetchedCitiesErrorSubject: BehaviorSubject<String?> = .init(value: nil)
    
    let coordinator: ForecastCoordinatorProtocol
    let networkingManager: NetworkingManagerProtocol
    let storageManager: StorageManagerProtocol
    
    init(coordinator: ForecastCoordinatorProtocol,
         networkingManager: NetworkingManagerProtocol,
         storageManager: StorageManagerProtocol) {
        self.coordinator = coordinator
        self.networkingManager = networkingManager
        self.storageManager = storageManager
    }
    
    private func saveHistoryCity(city: City) {
        storageManager.saveCity(city: city)
    }
}

extension CitySearchViewModel: CitySearchViewModelProtocol {
    var fetchedCities: Driver<[City]> {
        fetchedCitiesSubject.asDriver(onErrorJustReturn: [])
    }
    
    var fetchedCitiesError: Driver<String?> {
        fetchedCitiesErrorSubject.asDriver(onErrorJustReturn: nil)
    }
    
    func fetchCities(cityString: String) async {
        do {
            let cities = try await networkingManager.fetchWeatherCities(cityString: cityString)
            fetchedCitiesSubject.onNext(cities)
        } catch {
            fetchedCitiesErrorSubject.onNext(error.localizedDescription)
        }
    }
    
    func getHistoryCities() -> [City] {
        storageManager.loadCities()
    }
    
    func navigateToForecastDetails(with city: City) {
        saveHistoryCity(city: city)
        coordinator.navigateToForecastDetails(with: city)
    }
}
