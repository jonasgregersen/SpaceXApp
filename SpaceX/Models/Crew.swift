//
//  CrewMember.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import Foundation

/// Model der repræsenterer et crew-tilknytning til et launch.
/// Indeholder kun crew ID og rolle, som kobler til et CrewMember objekt.
struct Crew: Decodable, Hashable {
    let crew: String
    let role: String
}

/// Model der repræsenterer et crew medlem hentet fra API.
/// Indeholder information som navn, agenty, billeder og tilknyttede launches.
struct CrewMember: Decodable, Hashable, Identifiable {
    let id: String
    let name: String
    let agency: String?
    let image: URL?
    let wikipedia: URL?
    let launches: [String]?
    let status: String
}

// Preview data til SwiftUI Previews
extension Crew {
    static let preview: Crew = Crew(crew: "62dd7253202306255024d13f", role: "Pilot")
        
}
