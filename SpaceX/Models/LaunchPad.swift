//
//  Launchpad.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import Foundation

/// Model der repræsenterer en SpaceX launchpad hentet fra API'et.
/// Indeholder information om pad navn, lokation, koordinater og launches.
struct LaunchPad: Decodable, Identifiable, Equatable {
    let id: String
    let name: String
    let full_name: String
    let locality: String
    let region: String
    let latitude: Double
    let longitude: Double
    let launch_attempts: Int
    let launch_successes: Int
    let rockets: [String]
    let timezone: String
    let launches: [String]
    let status: String?
    let details: String?
}


