//
//  CitySearchView+TableViewDataSource.swift
//  WeatherApp
//
//  Created by Wojciech Kudrynski on 09/02/2024.
//

import UIKit

extension CitySearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cityCellReuseIdentifier, for: indexPath) as? CityCell
        
        cell?.setup(with: cities[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
