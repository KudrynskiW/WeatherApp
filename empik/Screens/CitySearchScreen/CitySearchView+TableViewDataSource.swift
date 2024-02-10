//
//  CitySearchView+TableViewDataSource.swift
//  empik
//
//  Created by Wojciech Kudrynski on 09/02/2024.
//

import UIKit

extension CitySearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as? CityCell
        
        cell?.setup(with: cities[indexPath.row])
        
        return cell ?? UITableViewCell()
    }
}
