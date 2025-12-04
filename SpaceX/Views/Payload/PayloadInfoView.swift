//
//  PayloadInfoView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import SwiftUI

struct PayloadInfoView: View {
    let payload: Payload

    var body: some View {
        List {
            Section("Basic Info") {
                Text("Name: \(payload.name)")
                Text("Type: \(payload.type)")
                Text("Reused: \(payload.reused ? "Yes" : "No")")
                
                if let mass = payload.mass_kg {
                    Text("Mass: \(mass) kg")
                }
            }

            if let customers = payload.customers, !customers.isEmpty {
                Section("Customers") {
                    ForEach(customers, id: \.self) { customer in
                        Text(customer)
                    }
                }
            }

            Section("Orbit") {
                Text("Orbit: \(payload.orbit ?? "-")")
                Text("Apoapsis: \(payload.apoapsis_km ?? 0, specifier: "%.0f") km")
                Text("Periapsis: \(payload.periapsis_km ?? 0, specifier: "%.0f") km")
            }

            if let dragon = payload.dragon {
                Section("Dragon Capsule") {
                    Text("Capsule: \(dragon.capsule ?? "-")")

                    if let massReturned = dragon.mass_returned_kg {
                        Text("Returned Mass: \(massReturned) kg")
                    }

                    if let time = dragon.flight_time_sec {
                        Text("Flight Time: \(time) sec")
                    }

                    if let manifest = dragon.manifest {
                        Text("Manifest: \(manifest)")
                    }

                    Text("Water Landing: \(dragon.water_landing == true ? "Yes" : "No")")
                    Text("Land Landing: \(dragon.land_landing == true ? "Yes" : "No")")
                }
            }
        }
        .navigationTitle(payload.name)
    }
}


