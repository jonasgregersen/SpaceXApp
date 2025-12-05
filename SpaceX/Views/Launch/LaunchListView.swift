//
//  LaunchListView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import SwiftUI

struct LaunchListView: View {
    var launches: [Launch]
    var title: String?
    @State private var path = NavigationPath()
    @EnvironmentObject private var mapVM: MapViewModel
    @EnvironmentObject private var userFavVM: UserFavoritesViewModel
    @EnvironmentObject private var favLaunchVM: FavoriteLaunchesViewModel
    @EnvironmentObject private var authVM: AuthViewModel
    
    var body: some View {
        Group {
            if launches.isEmpty {
                VStack {
                    Spacer()
                    Text("No launches to show.")
                        .padding()
                        .foregroundColor(.secondary)
                    Spacer()
                }
            } else {
                List(launches) {
                    launch in
                    NavigationLink(value: launch) {
                        LaunchRowView(launch: launch)
                    }
                    .swipeActions {
                        if authVM.isLoggedIn {
                            Button {
                                Task {
                                    await userFavVM.toggleFavorite(launch.id)
                                    favLaunchVM.reload()
                                    await favLaunchVM.loadLaunches(for: userFavVM.favoriteIds)
                                    
                                }
                            } label: {
                                Label("Favorite", systemImage: "star")
                            }
                            .tint(.yellow)
                        }
                    }
                }
                .navigationDestination(for: Launch.self) { launch in LaunchDetailView(launch: launch).environmentObject(mapVM)
                }
                .background(Color.black)
                .navigationTitle(title ?? "")
            }
        }
    }
    
}


