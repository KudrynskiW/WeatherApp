//
//  ForecastCoordinator.swift
//  empik
//
//  Created by Wojciech Kudrynski on 10/02/2024.
//

import UIKit

protocol ForecastCoordinatorProtocol: AnyObject {
    func navigateToForecastDetails(with city: City)
}

final class ForecastCoordinator {
    let navigationController: UINavigationController
    let componentsFactory: ForecastCoordinatorComponentsFactoryProtocol
    
    init(navigationController: UINavigationController,
         componentsFactory: ForecastCoordinatorComponentsFactoryProtocol) {
        self.navigationController = navigationController
        self.componentsFactory = componentsFactory
        
        start()
    }
    
    private func start() {
        let vc = componentsFactory.prepareCitySearchView(with: self)
        
        navigationController.pushViewController(vc, animated: true)
    }
}

extension ForecastCoordinator: ForecastCoordinatorProtocol {
    func navigateToForecastDetails(with city: City) {
        let vc = componentsFactory.prepareForecastDetailsView(with: self, city: city)
        
        navigationController.pushViewController(vc, animated: true)
    }
}
