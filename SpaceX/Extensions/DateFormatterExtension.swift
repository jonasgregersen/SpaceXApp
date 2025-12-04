//
//  DateFormatter.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import Foundation

// Custom dateformatter til visning i UI.
extension DateFormatter {
    static let uiDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "d MMMM yyyy 'at' HH:mm 'CET"
        return formatter
    }()
}
