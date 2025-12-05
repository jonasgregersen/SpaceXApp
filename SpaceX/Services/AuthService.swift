//
//  AuthentificateService.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import Foundation
import FirebaseAuth

/// AuthService håndterer brugerautentifikation via Firebase.
/// Implementerer AuthServiceProtocol, så ViewModels kan interagere med service uden at kende detaljerne.
class AuthService: AuthServiceProtocol {
    var currentUser: User? {
        Auth.auth().currentUser
    }
    
    // Login funktion til bruger med email og password
    func signin(email: String, password: String) async throws -> User {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        return result.user
    }
    
    // Opret bruger funktion med email og password
    func signup(email: String, password: String) async throws -> User {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        return result.user
    }
    
    // Log ud funktion for brugeren
    func signout() throws {
        try Auth.auth().signOut()
    }
}
