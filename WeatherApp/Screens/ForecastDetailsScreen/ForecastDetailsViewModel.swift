//
//  ForecastDetailsViewModel.swift
//  WeatherApp
//
//  Created by Wojciech Kudrynski on 10/02/2024.
//

import RxSwift
import RxCocoa

protocol ForecastDetailsViewModelProtocol {
    var cityDetails: Driver<ForecastCity?> { get }
    var forecastResponseError: Driver<String?> { get }
    var forecastEntryList: Driver<[String: [ForecastEntry]]> { get }
}

final class ForecastDetailsViewModel {
    let coordinator: ForecastCoordinatorProtocol
    let networkingManager: NetworkingManagerProtocol
    
    let forecastResponseSubject: BehaviorSubject<ForecastResponse?> = .init(value: nil)
    let forecastResponseErrorSubject: BehaviorSubject<String?> = .init(value: nil)
    let cityDetailsSubject: BehaviorSubject<ForecastCity?> = .init(value: nil)
    let forecastEntryListSubject: BehaviorSubject<[String: [ForecastEntry]]> = .init(value: [:])
    
    var forecastResponse: Driver<ForecastResponse?> {
        forecastResponseSubject.asDriver(onErrorJustReturn: nil)
    }
    
    let city: City
    let disposeBag = DisposeBag()
    
    init(city: City,
         coordinator: ForecastCoordinatorProtocol,
         networkingManager: NetworkingManagerProtocol) {
        self.city = city
        self.coordinator = coordinator
        self.networkingManager = networkingManager
        
        setupBindings()
    }
    
    func setupBindings() {
        Task {
            await fetchForecastDetails()
        }
        
        forecastResponse.drive(with: self) { owner, response in
            guard let response else { return }
            owner.cityDetailsSubject.onNext(response.city)
            
            var dateCollection: [String: [ForecastEntry]] = [:]
            response.list.forEach { entry in
                if let alreadyPresentValue = dateCollection[entry.dt.formatUTCDateMinimalDate()] {
                    dateCollection[entry.dt.formatUTCDateMinimalDate()] = alreadyPresentValue + [entry]
                } else {
                    dateCollection[entry.dt.formatUTCDateMinimalDate()] = [entry]
                }
            }
            
            owner.forecastEntryListSubject.onNext(dateCollection)
            
        }
        .disposed(by: disposeBag)
    }
    
    private func fetchForecastDetails() async {
        do {
            let response = try await networkingManager.fetchWeatherDetailsForCity(cityLat: city.lat, cityLong: city.lon)
            forecastResponseSubject.onNext(response)
        } catch {
            forecastResponseErrorSubject.onNext(error.localizedDescription)
        }
    }
}

extension ForecastDetailsViewModel: ForecastDetailsViewModelProtocol {
    var cityDetails: Driver<ForecastCity?> {
        cityDetailsSubject.asDriver(onErrorJustReturn: nil)
    }
    
    var forecastResponseError: Driver<String?> {
        forecastResponseErrorSubject.asDriver(onErrorJustReturn: nil)
    }
    
    var forecastEntryList: Driver<[String: [ForecastEntry]]> {
        forecastEntryListSubject.asDriver(onErrorJustReturn: [:])
    }
}
