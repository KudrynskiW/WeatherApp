//
//  CityCell.swift
//  empik
//
//  Created by Wojciech Kudrynski on 09/02/2024.
//

import UIKit

class CityCell: UITableViewCell {
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        return nameLabel
    }()
    
    lazy var detailsLabel: UILabel = {
        let detailsLabel = UILabel()
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
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16)
        ])
    }
    
    private func setupDetailsLabelView() {
        contentView.addSubview(detailsLabel)
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            detailsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            detailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            detailsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
