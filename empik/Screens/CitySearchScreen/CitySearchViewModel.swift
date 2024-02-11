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
    func navigateToForecastDetails(with city: City)
    
    var fetchedCities: Driver<[City]> { get }
    var fetchedCitiesError: Driver<String?> { get }
}

final class CitySearchViewModel {
    private var fetchedCitiesSubject: BehaviorSubject<[City]> = .init(value: [])
    private var fetchedCitiesErrorSubject: BehaviorSubject<String?> = .init(value: nil)
    
    let coordinator: ForecastCoordinatorProtocol
    let networkingManager: NetworkingManagerProtocol
    
    init(coordinator: ForecastCoordinatorProtocol,
         networkingManager: NetworkingManagerProtocol) {
        self.coordinator = coordinator
        self.networkingManager = networkingManager
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
    
    func navigateToForecastDetails(with city: City) {
        coordinator.navigateToForecastDetails(with: city)
    }
}
