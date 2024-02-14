//
//  ForecastDetailsView.swift
//  WeatherApp
//
//  Created by Wojciech Kudrynski on 10/02/2024.
//

import UIKit
import RxSwift

class ForecastDetailsView: UIViewController {
    enum Constants {
        static let cityDetailsCellReuseIdentifier = "CityDetailsCell"
        static let forecastEntryCellReuseIdentifier = "ForecastEntryCell"
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.separatorInset = .zero
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.register(CityDetailsCell.self, forCellReuseIdentifier: Constants.cityDetailsCellReuseIdentifier)
        tableView.register(ForecastEntryCell.self, forCellReuseIdentifier: Constants.forecastEntryCellReuseIdentifier)
        
        return tableView
    }()
    
    var forecastCity: ForecastCity?
    var forecastEntries: [(String, [ForecastEntry])] = []
    
    let viewModel: ForecastDetailsViewModelProtocol?
    private let disposeBag = DisposeBag()
    
    init(viewModel: ForecastDetailsViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        navigationController?.navigationBar.backgroundColor = .empBackground
        view.backgroundColor = .empBackground
        
        setupBindings()
        setupViews()
    }
    
    private func setupBindings() {
        viewModel?.cityDetails
            .drive(with: self, onNext: { owner, city in
                guard let city else { return }
                owner.title = "\(city.name)(\(city.country))"
                owner.forecastCity = city
                owner.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel?.forecastEntryList
            .drive(with: self, onNext: { owner, entries in
                owner.forecastEntries = entries.sorted(by: { (Double($0.key) ?? 0) < (Double($1.key) ?? 0) })
                
                owner.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func setupViews() {
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
