//
//  DateFormatter.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import Foundation

/// Custom DateFormatter til visning af datoer i UI.
/// Bruges til at formatere launch-datoer på en læsbar måde.
extension DateFormatter {
    static let uiDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "d MMMM yyyy 'at' HH:mm 'CET"
        return formatter
    }()
}
