//
//  LaunchListView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import SwiftUI

// Dette View håndterer listevisning af launches. Viewet er modulariseret for pålidelig genbrug, som sikrer ensartet LaunchListViews i applikationen. Indeholder en funktion for at tilføje launches til favorit ved swipe action.
struct LaunchListView: View {
    var launches: [Launch]
    var title: String?
    @EnvironmentObject private var mapVM: MapViewModel
    @EnvironmentObject private var userFavVM: UserFavoritesViewModel
    @EnvironmentObject private var favLaunchVM: FavoriteLaunchesViewModel
    @EnvironmentObject private var authVM: AuthViewModel
    
    var body: some View {
        Group {
            if launches.isEmpty { // Informér om tom liste.
                VStack {
                    Spacer()
                    Text("No launches to show.")
                        .padding()
                        .foregroundColor(.secondary)
                    Spacer()
                }
            } else {
                List(launches) { // Liste over launches
                    launch in
                    NavigationLink(value: launch) {
                        LaunchRowView(launch: launch)
                    }
                    .swipeActions {
                        if authVM.isLoggedIn { // Hvis brugeren er logget ind, kan man også swipe et launch på listen for at tilføje det til favoritter.
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


