//
//  FavoritesView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 03/12/2025.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favLaunchVM: FavoriteLaunchesViewModel
    @EnvironmentObject var userFavVM: UserFavoritesViewModel
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            LaunchListView(launches: favLaunchVM.favoriteLaunches, title: "Favorite Launches")
            .task {
                // Først load favorite IDs
                await userFavVM.loadFavorites()
                // Dernæst hent Launch objekter baseret på IDs
                await favLaunchVM.loadLaunches(for: userFavVM.favoriteIds)
            }
        }
        .background(Color.black)
    }
}



