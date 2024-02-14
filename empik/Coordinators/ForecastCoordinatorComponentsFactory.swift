//
//  ForecastCoordinatorComponentsFactory.swift
//  empik
//
//  Created by Wojciech Kudrynski on 10/02/2024.
//

import UIKit

protocol ForecastCoordinatorComponentsFactoryProtocol {
    func prepareCitySearchView(with coordinator: ForecastCoordinatorProtocol) -> UIViewController
    func prepareForecastDetailsView(with coordinator: ForecastCoordinatorProtocol, city: City) -> UIViewController
}

class ForecastCoordinatorComponentsFactory {
    init() { }
}

extension ForecastCoordinatorComponentsFactory: ForecastCoordinatorComponentsFactoryProtocol {
    func prepareCitySearchView(with coordinator: ForecastCoordinatorProtocol) -> UIViewController {
        let networkingManager = NetworkingManager.shared
        let viewModel = CitySearchViewModel(coordinator: coordinator,
                                            networkingManager: networkingManager, 
                                            storageManager: StorageManager.shared)
        
        return CitySearchView(viewModel: viewModel)
    }
    
    func prepareForecastDetailsView(with coordinator: ForecastCoordinatorProtocol, city: City) -> UIViewController {
        let networkingManager = NetworkingManager.shared
        let viewModel = ForecastDetailsViewModel(city: city,
                                                 coordinator: coordinator,
                                                 networkingManager: networkingManager)
        
        return ForecastDetailsView(viewModel: viewModel)
    }
}
