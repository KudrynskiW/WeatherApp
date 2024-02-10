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
        
        return nameLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupNameLabelView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(with city: City) {
        nameLabel.text = city.name
    }
    
    private func setupNameLabelView() {
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            nameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
