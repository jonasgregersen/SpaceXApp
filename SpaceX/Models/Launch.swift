//
//  LaunchModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//
import Foundation

/// Model der repræsenterer en SpaceX launch hentet fra API'et.
/// Indeholder information som navn, dato, successtatus, tilknyttede kapsler, payloads, crew og links til billeder.
struct Launch: Decodable, Identifiable, Hashable {
    /// Links til relaterede medier og billeder for launchen
    struct Links: Decodable, Hashable {
        let patch: Patch
    }

    /// Patch-billeder for launchen (small og large)
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
    
    /// Hjælpeproperty til at få patch billedet
    var patchImage: URL? {links.patch.small}
    
    /// Mapping fra JSON keys til Swift properties
    enum CodingKeys: String, CodingKey {
            case id, name, details, rocket, success, capsules, payloads, crew
            case dateUTC = "date_utc"
            case launchPad = "launchpad"
            case links
        }
}









