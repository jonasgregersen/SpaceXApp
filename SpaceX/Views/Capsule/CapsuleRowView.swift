//
//  CapsuleRowView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import SwiftUI

// Dette View håndterer relevante oplysninger for en capsule, som vises i CapsuleListView
struct CapsuleRowView: View {
    var capsule: Capsule

    var body: some View {
        HStack(spacing: 16) {
            // ICON / type indicator
            Image(systemName: capsule.status.lowercased() == "active" ? "capsule.fill" : "capsule")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(capsule.status.lowercased() == "active" ? .green : .gray)
            
            // INFO
            VStack(alignment: .leading, spacing: 4) {
                Text(capsule.serial)
                    .bold()
                Text(capsule.type.capitalized)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(capsule.status.capitalized)
                    .font(.caption2)
                    .foregroundColor(capsule.status.lowercased() == "active" ? .green : .red)
                
                HStack(spacing: 8) {
                    if let reuse = capsule.reuse_count {
                        Label("\(reuse) reuse", systemImage: "repeat")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    if let water = capsule.water_landings {
                        Label("\(water) water", systemImage: "drop.fill")
                            .font(.caption2)
                            .foregroundColor(.blue)
                    }
                    if let land = capsule.land_landings {
                        Label("\(land) land", systemImage: "house.fill")
                            .font(.caption2)
                            .foregroundColor(.brown)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
        )
    }
}




