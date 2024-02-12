//
//  Int+extensions.swift
//  empik
//
//  Created by Wojciech Kudrynski on 12/02/2024.
//

import Foundation

extension Int {
    func formatUTCDate(dateStyle: DateFormatter.Style = .none, timeStyle: DateFormatter.Style = .short) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        return dateFormatter.string(from: date)
    }
    
    func formatUTCDateMinimalDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        return dateFormatter.string(from: date)
    }
}
