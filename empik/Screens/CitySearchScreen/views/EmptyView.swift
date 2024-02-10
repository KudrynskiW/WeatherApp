//
//  EmptyView.swift
//  empik
//
//  Created by Wojciech Kudrynski on 09/02/2024.
//

import UIKit

class EmptyView: UIView {
    lazy var emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "aqi.high")
        imageView.tintColor = .black
        return imageView
    }()
    
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "No Results"
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        addSubview(emptyImageView)
        addSubview(emptyLabel)
        
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyImageView.topAnchor.constraint(equalTo: topAnchor),
            emptyImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyImageView.heightAnchor.constraint(equalToConstant: 150),
            emptyImageView.widthAnchor.constraint(equalToConstant: 200),
            emptyLabel.topAnchor.constraint(equalTo: emptyImageView.bottomAnchor),
            emptyLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            emptyLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            emptyLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
}
