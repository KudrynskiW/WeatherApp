//
//  CityDetailsCell.swift
//  empik
//
//  Created by Wojciech Kudrynski on 12/02/2024.
//

import UIKit
import MapKit

class CityDetailsCell: UITableViewCell {
    private enum Constants {
        static let horizontalMargin: CGFloat = 16
    }
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.isUserInteractionEnabled = false
        return mapView
    }()
    
    lazy var populationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        return label
    }()
    
    lazy var sunLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(with city: ForecastCity) {
        let coordinates = CLLocationCoordinate2DMake(city.coord.lat, city.coord.lon)
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        mapView.setRegion(region, animated: false)
        
        sunLabel.text = "🌝\(city.sunrise.formatUTCDate()) - 🌚\(city.sunset.formatUTCDate())"
        
        populationLabel.text = "👤\(city.population)"
    }
    
    private func setupView() {
        setupMapView()
        setupSunLabel()
        setupPopulatonLabel()
    }
    
    private func setupMapView() {
        addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setupSunLabel() {
        addSubview(sunLabel)
        
        sunLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sunLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: Constants.horizontalMargin),
            sunLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalMargin)
        ])
    }
    
    private func setupPopulatonLabel() {
        addSubview(populationLabel)
        
        populationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            populationLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: Constants.horizontalMargin),
            populationLabel.leadingAnchor.constraint(equalTo: sunLabel.leadingAnchor),
            populationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalMargin),
            populationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.horizontalMargin)
        ])
    }
    
    
    
}
