//
//  CrewMember.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import Foundation

struct Crew: Codable, Hashable {
    let crew: String
    let role: String
}

struct CrewMember: Codable, Hashable, Identifiable {
    let id: String
    let name: String
    let agency: String?
    let image: URL?
    let wikipedia: URL?
    let launches: [String]?
    let status: String
}

extension Crew {
    static let preview: Crew = Crew(crew: "62dd7253202306255024d13f", role: "Pilot")
        
}
