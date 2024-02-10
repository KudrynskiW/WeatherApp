//
//  CitySearchView+SearchBarDelegate.swift
//  empik
//
//  Created by Wojciech Kudrynski on 10/02/2024.
//

import UIKit

extension CitySearchView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            emptyView.isHidden = false
            cities = []
            tableView.reloadData()
            return
        }
        
        Task {
            await viewModel?.fetchCities(cityString: searchText)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let allowedCharacters = CharacterSet.letters
        let characterSet = CharacterSet(charactersIn: text)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

