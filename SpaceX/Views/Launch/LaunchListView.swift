//
//  LaunchListView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import SwiftUI

/// Modulariseret listeview til launches.
/// Kan genbruges i hele appen med ensartet udseende og funktionalitet.
/// Understøtter swipe-actions til at tilføje launches til favorit for indloggede brugere.
struct LaunchListView: View {
    var launches: [Launch]
    var title: String?
    @EnvironmentObject private var mapVM: MapViewModel
    @EnvironmentObject private var userFavVM: UserFavoritesViewModel
    @EnvironmentObject private var favLaunchVM: FavoriteLaunchesViewModel
    @EnvironmentObject private var authVM: AuthViewModel
    
    var body: some View {
        Group {
            // Vis tom state hvis der ikke er launches
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
                    // Navigering til detaljevisning af launch
                    NavigationLink(value: launch) {
                        LaunchRowView(launch: launch)
                    }
                    .swipeActions {
                        // Tillader indloggede brugere at tilføje launches til favorit
                        if authVM.isLoggedIn {
                            Button {
                                Task {
                                    await userFavVM.toggleFavorite(launch.id)
                                    await favLaunchVM.reload(for: userFavVM.favoriteIds)
                                    
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


