//
//  CityCell.swift
//  empik
//
//  Created by Wojciech Kudrynski on 09/02/2024.
//

import UIKit

class CityCell: UITableViewCell {
    private enum Constants {
        static let standardMargin: CGFloat = 16
    }
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        return nameLabel
    }()
    
    lazy var detailsLabel: UILabel = {
        let detailsLabel = UILabel()
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        detailsLabel.font = .systemFont(ofSize: 12, weight: .thin)
        return detailsLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupNameLabelView()
        setupDetailsLabelView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(with city: City) {
        nameLabel.text = city.name
        detailsLabel.text = "\(city.state) in \(city.country)"
    }
    
    private func setupNameLabelView() {
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.standardMargin),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.standardMargin),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.standardMargin)
        ])
    }
    
    private func setupDetailsLabelView() {
        contentView.addSubview(detailsLabel)
        
        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            detailsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.standardMargin),
            detailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.standardMargin),
            detailsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.standardMargin)
        ])
    }
}
