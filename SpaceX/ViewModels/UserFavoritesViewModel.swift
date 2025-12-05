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
final class UserFavoritesViewModel: ObservableObject {
    @Published var favoriteIds: [String] = []
    
    private var hasLoaded: Bool = false
    
    private let service: UserFavoritesServiceProtocol
    
    init(service: UserFavoritesServiceProtocol) {
        self.service = service
    }
    
    func loadFavorites() async {
        do {
            guard !hasLoaded else { return } // Hvis allerede indlæst og ikke opdateret, kør ikke.
            let ids = try await service.loadFavorites()
            favoriteIds = ids
            hasLoaded = true
        } catch {
            print("Error loading favorites: \(error)")
        }
    }
    
    func reload() async {
        hasLoaded = false
        await loadFavorites()
    }
    
    // Genbrug samme favorit knap til at tilføje og fjerne fra favoritter.
    func toggleFavorite(_ id: String) async {
        if favoriteIds.contains(id) {
            favoriteIds.removeAll { $0 == id }
            try? await service.removeFavorite(id)
        } else {
            favoriteIds.append(id)
            try? await service.addFavorite(id)
        }
        hasLoaded = false // Angiver favorites som ikke indlæst, så de kan indlæses igen.
    }
    
    func isFavorite(_ id: String) -> Bool {
        favoriteIds.contains(id)
    }
}
