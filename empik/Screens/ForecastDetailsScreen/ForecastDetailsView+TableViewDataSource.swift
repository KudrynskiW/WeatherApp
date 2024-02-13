//
//  ForecastDetailsView+TableViewDataSource.swift
//  empik
//
//  Created by Wojciech Kudrynski on 12/02/2024.
//

import UIKit

extension ForecastDetailsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1 + forecastEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            let cityDetailsCell = tableView.dequeueReusableCell(withIdentifier: "CityDetailsCell", for: indexPath) as? CityDetailsCell
            
            if let forecastCity {
                cityDetailsCell?.setupCell(with: forecastCity)
            }
            
            return cityDetailsCell ?? cell
        case 1...forecastEntries.map({ $0.0 }).count:
            let forecastEntryCell = tableView.dequeueReusableCell(withIdentifier: "ForecastEntryCell", for: indexPath) as? ForecastEntryCell
            
            let keys = forecastEntries.map({ $0.0 })
            let selectedKey = keys[indexPath.row-1]
            let entries = forecastEntries.first(where: { $0.0 == selectedKey }).map({ $0.1 })
            
            forecastEntryCell?.setupCell(date: selectedKey, forecastEntries: entries ?? [])
            
            return forecastEntryCell ?? cell
        default:
            return cell
        }
    }
}
