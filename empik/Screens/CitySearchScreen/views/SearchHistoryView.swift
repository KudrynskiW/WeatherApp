//
//  SearchHistoryView.swift
//  empik
//
//  Created by Wojciech Kudrynski on 13/02/2024.
//

import UIKit

class SearchHistoryView: UIView {
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    lazy var scrollStackViewContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    weak var coordinator: ForecastCoordinatorProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addHistoryEntry(coordinator: ForecastCoordinatorProtocol?, city: City) {
        let historyEntryView: HistoryEntryView = {
            let entryView = HistoryEntryView()
            entryView.translatesAutoresizingMaskIntoConstraints = false
            entryView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            return entryView
        }()
        
        scrollStackViewContainer.addArrangedSubview(historyEntryView)
        historyEntryView.setupCity(coordinator: coordinator, city: city)
    }
    
    func clearHistory() {
        for view in scrollStackViewContainer.arrangedSubviews {
            view.removeFromSuperview()
        }
    }
    
    private func configureStackView() {
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        scrollView.addSubview(scrollStackViewContainer)
        NSLayoutConstraint.activate([
            scrollStackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollStackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollStackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollStackViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}
