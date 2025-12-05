//
//  DateDecoder.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import Foundation

// Formattér date_UTC fra launch api'et.
extension JSONDecoder.DateDecodingStrategy {
    static let iso8601WithFractionalSeconds: JSONDecoder.DateDecodingStrategy = .custom { decoder in
        let container = try decoder.singleValueContainer()
        let dateStr = try container.decode(String.self)

        struct Static { // Formatterer UTC dato med fractional seconds.
            static let formatter: ISO8601DateFormatter = {
                let f = ISO8601DateFormatter()
                f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                return f
            }()
        }

        if let date = Static.formatter.date(from: dateStr) {
            return date
        }

        throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid ISO8601 date: \(dateStr)"
        )
    }
}

