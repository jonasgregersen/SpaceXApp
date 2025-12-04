//
//  AuthentificateService.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import Foundation
import FirebaseAuth

class AuthService: AuthServiceProtocol {
    var currentUser: User? {
        Auth.auth().currentUser
    }
    
    // Login funktion til bruger
    func signin(email: String, password: String) async throws -> User {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        return result.user
    }
    
    
    func signup(email: String, password: String) async throws -> User {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        return result.user
    }
    
    func signout() throws {
        try Auth.auth().signOut()
    }
}
