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
        static let standardMargin: CGFloat = 16
    }
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.isUserInteractionEnabled = false
        
        return mapView
    }()
    
    lazy var populationLabel: UILabel = {
        let populationLabel = UILabel()
        populationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        populationLabel.textAlignment = .right
        
        return populationLabel
    }()
    
    lazy var sunLabel: UILabel = {
        let sunLabel = UILabel()
        sunLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return sunLabel
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
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func setupSunLabel() {
        addSubview(sunLabel)
        
        NSLayoutConstraint.activate([
            sunLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: Constants.standardMargin),
            sunLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.standardMargin)
        ])
    }
    
    private func setupPopulatonLabel() {
        addSubview(populationLabel)
        
        NSLayoutConstraint.activate([
            populationLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: Constants.standardMargin),
            populationLabel.leadingAnchor.constraint(equalTo: sunLabel.leadingAnchor),
            populationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.standardMargin),
            populationLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.standardMargin)
        ])
    }
    
    
    
}
