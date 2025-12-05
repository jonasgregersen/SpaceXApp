//
//  LaunchListView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import SwiftUI

struct AllLaunchesView: View {
    @EnvironmentObject private var launchVM: LaunchViewModel
    
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            LaunchListView(launches: launchVM.launches, title: "All Launches")
                .onAppear {
                    Task {
                        await launchVM.load() // Load alle launches og injicere dem i launchlistview.
                    }
                }
                .overlay {
                    if launchVM.isLoading {
                        ProgressView("Henter launches...")
                    }
                }
                .refreshable {
                    await launchVM.reload()
                } // Træk listen ned for at genindlæse launches.
        }
    }
}


