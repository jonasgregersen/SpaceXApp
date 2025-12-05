//
//  DateDecoder.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import Foundation

/// Custom DateDecodingStrategy for JSONDecoder, der håndterer ISO8601-datoer med fractional seconds.
/// Bruges til at dekode date_utc fra Launch API'et korrekt
extension JSONDecoder.DateDecodingStrategy {
    static let iso8601WithFractionalSeconds: JSONDecoder.DateDecodingStrategy = .custom { decoder in
        // Hent dato som String fra JSON
        let container = try decoder.singleValueContainer()
        let dateStr = try container.decode(String.self)

        // Formatter med fractional seconds
        struct Static {
            static let formatter: ISO8601DateFormatter = {
                let f = ISO8601DateFormatter()
                f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                return f
            }()
        }
        
        // Konverter String til Date
        if let date = Static.formatter.date(from: dateStr) {
            return date
        }

        // Fejl hvis datoen ikke kan parses
        throw DecodingError.dataCorruptedError(
            in: container,
            debugDescription: "Invalid ISO8601 date: \(dateStr)"
        )
    }
}

