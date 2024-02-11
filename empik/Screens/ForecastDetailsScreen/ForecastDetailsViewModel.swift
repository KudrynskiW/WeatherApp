//
//  ForecastDetailsViewModel.swift
//  empik
//
//  Created by Wojciech Kudrynski on 10/02/2024.
//

import RxSwift
import RxCocoa

protocol ForecastDetailsViewModelProtocol {
    var forecastResponse: Driver<ForecastResponse?> { get }
    var forecastResponseError: Driver<String?> { get }
}

final class ForecastDetailsViewModel {
    let coordinator: ForecastCoordinatorProtocol
    let networkingManager: NetworkingManagerProtocol
    
    let forecastResponseSubject: BehaviorSubject<ForecastResponse?> = .init(value: nil)
    let forecastResponseErrorSubject: BehaviorSubject<String?> = .init(value: nil)
    let cityDetailsSubject: BehaviorSubject<ForecastCity?> = .init(value: nil)
    let forecastEntryListSubject: BehaviorSubject<[ForecastEntry]> = .init(value: [])
    
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
            owner.forecastEntryListSubject.onNext(response.list)
            print(response.city)
            
        }.disposed(by: disposeBag)
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
    var forecastResponse: Driver<ForecastResponse?> {
        forecastResponseSubject.asDriver(onErrorJustReturn: nil)
    }
    
    var forecastResponseError: Driver<String?> {
        forecastResponseErrorSubject.asDriver(onErrorJustReturn: nil)
    }
}
