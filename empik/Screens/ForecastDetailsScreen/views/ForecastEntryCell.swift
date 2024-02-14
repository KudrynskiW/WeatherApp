//
//  ForecastEntryCell.swift
//  empik
//
//  Created by Wojciech Kudrynski on 12/02/2024.
//

import UIKit

class ForecastEntryCell: UITableViewCell {
    private enum Constants {
        static let standardMargin: CGFloat = 16
    }
    
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return dateLabel
    }()
    
    lazy var temperatureLabel: UILabel = {
        let temperatureLabel = UILabel()
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.textAlignment = .center
        
        return temperatureLabel
    }()
    
    lazy var averageTemperatireLabel: UILabel = {
        let averageTemperatireLabel = UILabel()
        averageTemperatireLabel.translatesAutoresizingMaskIntoConstraints = false
        
        averageTemperatireLabel.textAlignment = .right
        
        return averageTemperatireLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(date: String, forecastEntries: [ForecastEntry]) {
        
        let forecastEntry = forecastEntries.first!
        let minMaxAttrString: NSMutableAttributedString = NSMutableAttributedString(string: "(Min: ")
        let (minTemp, maxTemp) = returnMinAndMaxTemp(from: forecastEntries)
        minMaxAttrString.append(prepareTemperatureString(temperature: minTemp))
        minMaxAttrString.append(.init(string: " | Max: "))
        minMaxAttrString.append(prepareTemperatureString(temperature: maxTemp))
        minMaxAttrString.append(.init(string: ")"))
        
        dateLabel.text = date
        temperatureLabel.attributedText = prepareTemperatureString(temperature: Int(forecastEntry.main.temp))
        averageTemperatireLabel.attributedText = minMaxAttrString
    }
    
    private func prepareTemperatureString(temperature: Int) -> NSAttributedString {
        var fontColor: UIColor
        
        switch temperature {
        case Int.min..<10:
            fontColor = .blue
        case 10...20:
            fontColor = .black
        case 21...Int.max:
            fontColor = .red
        default:
            fontColor = .clear
        }
        
        return NSAttributedString(string: "\(temperature)°C", attributes: [NSAttributedString.Key.foregroundColor : fontColor])
    }
    
    /// Data from api is not reliable, i will prepare my own
    private func returnMinAndMaxTemp(from entries: [ForecastEntry]) -> (Int, Int) {
        var minTemp = Int.max
        var maxTemp = Int.min
        
        entries.forEach { entry in
            minTemp = Int(entry.main.temp) < minTemp ? Int(entry.main.temp) : minTemp
            minTemp = Int(entry.main.temp_min) < minTemp ? Int(entry.main.temp_min) : minTemp
            
            maxTemp = Int(entry.main.temp) > maxTemp ? Int(entry.main.temp) : maxTemp
            maxTemp = Int(entry.main.temp_max) > maxTemp ? Int(entry.main.temp_max) : maxTemp
        }
        
        return (minTemp, maxTemp)
    }
    
    private func setupViews() {
        setupDateLabel()
        setupTemperatureLabel()
        setupAverageTemperatureLabel()
    }
    
    private func setupDateLabel() {
        addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.standardMargin),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.standardMargin),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.standardMargin),
            dateLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupTemperatureLabel() {
        addSubview(temperatureLabel)
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.standardMargin),
            temperatureLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: Constants.standardMargin),
            temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.standardMargin)
        ])
    }
    
    private func setupAverageTemperatureLabel() {
        addSubview(averageTemperatireLabel)
        
        NSLayoutConstraint.activate([
            averageTemperatireLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.standardMargin),
            averageTemperatireLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: Constants.standardMargin),
            averageTemperatireLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.standardMargin),
            averageTemperatireLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.standardMargin)
        ])
    }
}
