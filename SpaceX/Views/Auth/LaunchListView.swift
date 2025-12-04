//
//  LaunchListView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import SwiftUI

struct LaunchListView: View {
    @StateObject private var vm = LaunchViewModel()
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            List(vm.launches) {
                launch in
                NavigationLink(value: launch) {
                    LaunchRowView(launch: launch)
                }
            }
            .navigationDestination(for: Launch.self) { launch in LaunchDetailView(launch: launch)
            }
            .navigationTitle("Launches")
            .task {
                await vm.loadLaunches()
            }
            .overlay {
                if vm.isLoading {
                    ProgressView("Henter launches...")
                }
            }
        }
    }
}

#Preview {
    LaunchListView()
}
