//
//  RocketRowView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import SwiftUI

struct RocketInfoView: View {
    @EnvironmentObject private var vm: RocketViewModel
    var rocketId: String // tidligere `rocket: String`

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let rocket = vm.rocket {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(rocket.name)
                            .font(.title)
                            .bold()
                        Text(rocket.type.capitalized)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Dimensions")
                            .font(.headline)
                        Text("Height: \(rocket.height.meters ?? 0, specifier: "%.1f") m / \(rocket.height.feet ?? 0, specifier: "%.1f") ft")
                        Text("Diameter: \(rocket.diameter.meters ?? 0, specifier: "%.1f") m / \(rocket.diameter.feet ?? 0, specifier: "%.1f") ft")
                        Text("Mass: \(rocket.mass.meters ?? 0, specifier: "%.0f") kg") 
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Description")
                            .font(.headline)
                        Text(rocket.description)
                            .font(.body)
                    }
                    .padding(.horizontal)
                } else {
                    ProgressView("Loading rocket...")
                }
            }
            .padding()
        }
        .task {
            await vm.load(rocketId)
        }
    }
}

