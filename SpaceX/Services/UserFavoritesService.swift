//
//  UserFavoritesService.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 03/12/2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

/// UserFavoritesService håndterer indlæsning, tilføjelse og fjernelse af favorit-launches for den aktuelle bruger via Firestore.
/// Implementerer UserFavoritesServiceProtocol, så ViewModels kan arbejde med favoritter uden at kende Firestore-detaljer.
class UserFavoritesService: UserFavoritesServiceProtocol {
    private let db = Firestore.firestore()
    
    // Bruger reference til FireStore databasen.
    private var userRef: DocumentReference? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
        return db.collection("users").document(uid)
    }
    
    // Indlæser favorit launches fra FireStore for brugeren.
    func loadFavorites() async throws -> [String] {
        guard let ref = userRef else { return [] }
        
        let snap = try await ref.getDocument()
        print("Favorites snapshot: \(snap.data() ?? [:])")
        return snap.get("favorites") as? [String] ?? []
    }
    
    // Tilføjer launch til brugerens favoritter til FireStore.
    func addFavorite(_ id: String) async throws {
        guard let ref = userRef else { return }
        
        try await ref.setData([
            "favorites": FieldValue.arrayUnion([id])
        ], merge: true)
    }
    
    // Fjerner launch fra brugerens favoritter i FireStore.
    func removeFavorite(_ id: String) async throws {
        guard let ref = userRef else { return }
        
        try await ref.updateData([
            "favorites": FieldValue.arrayRemove([id])
        ])
    }
}
