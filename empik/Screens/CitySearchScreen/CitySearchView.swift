//
//  CitySearchView.swift
//  empik
//
//  Created by Wojciech Kudrynski on 09/02/2024.
//

import UIKit
import RxSwift

class CitySearchView: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(CityCell.self, forCellReuseIdentifier: "CityCell")
        
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        
        return searchBar
    }()
    
    lazy var emptyView: EmptyView = {
        let emptyView = EmptyView()
        return emptyView
    }()
    
    let viewModel: CitySearchViewModelProtocol?
    var cities: [City] = []
    private let disposeBag = DisposeBag()
    
    init(viewModel: CitySearchViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.viewModel = nil
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindData()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        setupSearchBar()
        setupTableView()
        setupEmptyView()
    }
    
    private func setupSearchBar() {
        view.addSubview(searchBar)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupEmptyView() {
        view.addSubview(emptyView)
        
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func bindData() {
        viewModel?.fetchedCities
            .drive(with: self, onNext: { owner, cities in
                owner.emptyView.isHidden = !cities.isEmpty
                owner.cities = cities
                
                owner.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
}
