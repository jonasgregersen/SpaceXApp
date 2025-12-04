//
//  LaunchModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//
import Foundation

struct Launch: Decodable, Identifiable, Hashable {
    struct Links: Decodable, Hashable {
        let patch: Patch
    }

    struct Patch: Decodable, Hashable {
        let small: URL?
        let large: URL?
    }
    let id: String
    let name: String
    let details: String?
    let rocket: String
    let success: Bool?
    let dateUTC: Date
    let capsules: [String]?
    let payloads: [String]?
    let crew: [Crew]? 
    let launchPad: String
    let links: Links
    
    var patchImage: URL? {links.patch.small}
    
    enum CodingKeys: String, CodingKey {
            case id, name, details, rocket, success, capsules, payloads, crew
            case dateUTC = "date_utc"
            case launchPad = "launchpad"
            case links
        }
}









