//
//  CitySearchView+SearchBarDelegate.swift
//  WeatherApp
//
//  Created by Wojciech Kudrynski on 10/02/2024.
//

import UIKit

extension CitySearchView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            emptyView.isHidden = false
            emptyView.mode = .provideName
            cities = []
            tableView.reloadData()
            loadHistoryTickets()
            return
        }
        
        Task {
            searchHistoryView.isHidden = true
            await viewModel?.fetchCities(cityString: searchText)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // just because its in requirements:
        let pattern = "[A-Za-ząćęłńóśźżĄĆĘŁŃÓŚŹŻ A-Za-ząćęłńóśźżĄĆĘŁŃÓŚŹŻ]"
        let allowedFormat = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: text.utf16.count)
        let matches = allowedFormat?.firstMatch(in: text, range: range)
        return matches?.range.length != nil
        
        /* 
        Better way to handle validation:
        let allowedCharacters = CharacterSet.letters
        let characterSet = CharacterSet(charactersIn: text)
        return allowedCharacters.isSuperset(of: characterSet)
        */
    }
}

