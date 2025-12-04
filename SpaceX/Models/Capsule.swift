//
//  Capsule.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import Foundation

struct Capsule: Codable, Identifiable {
    var id: String
    var reuse_count: Int
    var water_landings: Int
    var land_landings: Int
    var last_update: String
    var launches: [String]
    var serial: String
    var status: String
    var type: String
}
