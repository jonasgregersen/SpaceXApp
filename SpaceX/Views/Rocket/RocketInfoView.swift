//
//  RocketRowView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import SwiftUI

struct RocketRowView: View {
    @StateObject private var vm = RocketViewModel()
    var rocket: String
    var body: some View {
        HStack {
            VStack {
                if let rocket = vm.rocket {
                    Text(rocket.name)
                        .bold()
                    Text(rocket.type)
                        .font(.caption)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.secondarySystemBackground))
            )
            Spacer()
        }
        .task {
            await vm.loadRocket(rocket)
        }
    }
}

