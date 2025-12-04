//
//  Rocket.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import Foundation

struct Rocket: Codable, Identifiable {
    struct Dimension: Codable {
        let meters: Double?
        let feet: Double?
    }
    
    struct Stage: Codable {
        let engines: Int?
        let fuel_amount_tons: Double?
        let burn_time_sec: Int?
    }
    
    let id: String
    let name: String
    let type: String
    let active: Bool
    let stages: Int
    let boosters: Int
    let cost_per_launch: Int
    let success_rate_pct: Int
    let first_flight: String
    let country: String
    let company: String
    let description: String
    let height: Dimension
    let diameter: Dimension
    let mass: Dimension
    let flickr_images: [String]?
}
