//
//  UserViewModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 03/12/2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
class UserFavoritesViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var favoriteIds: [String] = []
    @Published var favoriteLaunches: [Launch] = []
    @Published var isLoading = false
    
    private let favService = UserFavoritesService()
    private let launchService = APIService.LaunchService()
    
    func loadFavorites() async {
        isLoading = true
        defer {isLoading = false}
        do {
            let ids = try await favService.loadFavorites()
            print("Loaded favorites into ViewModel: \(ids)")
            favoriteIds = ids
            await fetchLaunches()
            
        } catch {
            print("Error loading favorites:", error)
        }
    }
    
    func toggleFavorite(_ id: String) async {
        if isFavorite(id) {
            // Fjern lokalt
            favoriteIds.removeAll { $0 == id }
            favoriteLaunches.removeAll { $0.id == id }

            // Opdater Firestore
            try? await favService.removeFavorite(id)
        } else {
            // Tilføj lokalt
            favoriteIds.append(id)

            // Hent kun det nye launch
            if let launch = try? await launchService.getLaunchById(id) {
                favoriteLaunches.append(launch)
            }

            // Opdater Firestore
            try? await favService.addFavorite(id)
        }
    }

    
    func isFavorite(_ id: String) -> Bool {
        favoriteIds.contains(id)
    }
    
    func fetchLaunches() async {
        var launches: [Launch] = []
        for id in favoriteIds {
            do {
                let launch = try await launchService.getLaunchById(id)
                launches.append(launch)
            } catch {
                print("An error occured fetching favorite launches: \(error.localizedDescription)")
            }
        }
        favoriteLaunches = launches
    }
    
    
}
