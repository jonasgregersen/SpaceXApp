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
            guard !hasLoaded else { return }
            let ids = try await service.loadFavorites()
            favoriteIds = ids
            hasLoaded = true
        } catch {
            print("Error loading favorites: \(error)")
        }
    }
    
    func toggleFavorite(_ id: String) async {
        if favoriteIds.contains(id) {
            favoriteIds.removeAll { $0 == id }
            try? await service.removeFavorite(id)
        } else {
            favoriteIds.append(id)
            try? await service.addFavorite(id)
        }
        hasLoaded = false
    }
    
    func isFavorite(_ id: String) -> Bool {
        favoriteIds.contains(id)
    }
}
