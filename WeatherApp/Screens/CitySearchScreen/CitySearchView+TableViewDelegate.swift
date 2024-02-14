//
//  CitySearchView+TableViewDelegate.swift
//  WeatherApp
//
//  Created by Wojciech Kudrynski on 09/02/2024.
//

import UIKit

extension CitySearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        
        self.viewModel?.navigateToForecastDetails(with: cities[indexPath.row])
    }
}
