//
//  LaunchListView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import SwiftUI

// Dette View håndterer visning af et LaunchListView, samt bruger LaunchViewModel til indhentning af alle launches fra API'et.
struct AllLaunchesView: View {
    @EnvironmentObject private var launchVM: LaunchViewModel
    
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            LaunchListView(launches: launchVM.launches, title: "All Launches")
                .onAppear {
                    Task {
                        await launchVM.load() // Load alle launches og injicér dem i launchlistview.
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


