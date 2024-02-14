//
//  HistoryEntryView.swift
//  empik
//
//  Created by Wojciech Kudrynski on 13/02/2024.
//

import UIKit

class HistoryEntryView: UIView {
    private enum Constants {
        static let standardInset: CGFloat = 8
    }
    
    lazy var cityNameButton: UIButton = {
        let cityNameButton = UIButton()
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.plain()
            configuration.contentInsets = .init(top: Constants.standardInset, 
                                                leading: Constants.standardInset,
                                                bottom: Constants.standardInset,
                                                trailing: Constants.standardInset)
            
            cityNameButton.configuration = configuration
        } else {
            cityNameButton.contentEdgeInsets = .init(top: Constants.standardInset, 
                                                     left: Constants.standardInset,
                                                     bottom: Constants.standardInset,
                                                     right: Constants.standardInset)
        }
        
        cityNameButton.translatesAutoresizingMaskIntoConstraints = false
        
        cityNameButton.setTitleColor(.empText, for: .normal)
        cityNameButton.backgroundColor = .empBackground
        cityNameButton.layer.cornerRadius = 10
        
        return cityNameButton
    }()
    
    weak var coordinator: ForecastCoordinatorProtocol?
    var city: City?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCity(coordinator: ForecastCoordinatorProtocol?, city: City) {
        self.coordinator = coordinator
        self.city = city
        
        self.cityNameButton.setTitle("\(city.name)(\(city.country))", for: .normal)
        self.cityNameButton.addTarget(self, action: #selector(openCityDetails), for: .touchUpInside)
    }
    
    @objc
    private func openCityDetails() {
        if let city {
            coordinator?.navigateToForecastDetails(with: city)
        }
    }
    
    private func setupButton() {
        addSubview(cityNameButton)
        
        NSLayoutConstraint.activate([
            cityNameButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            cityNameButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            cityNameButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
