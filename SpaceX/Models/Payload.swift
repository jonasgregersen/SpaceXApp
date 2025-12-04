//
//  Payload.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//
import Foundation

struct Payload: Decodable, Identifiable {
    struct Dragon: Decodable {
        let capsule: String?
        let mass_returned_kg: Double?
        let mass_returned_lbs: Double?
        let flight_time_sec: Double?
        let manifest: String?
        let water_landing: Bool?
        let land_landing: Bool?
    }

    let id: String
    let name: String
    let type: String
    let reused: Bool
    let mass_kg: Double?
    let mass_lbs: Double?
    let customers: [String]?
    let orbit: String?
    let reference_system: String?
    let regime: String?
    let periapsis_km: Double?
    let apoapsis_km: Double?
    let inclination_deg: Double?
    let period_min: Double?
    let lifespan_years: Double?
    let dragon: Dragon?
}

