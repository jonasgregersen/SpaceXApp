//
//  AuthViewModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import Foundation
import FirebaseAuth

/// ViewModel der håndterer authentification af brugere via Firebase fra service.
/// Initialsieres med en service, der følger AuthServiceProtocol
/// Dette gør ViewModelen testbar (mocking) og uafhængig af konkrete service-implementeringer.
@MainActor
class AuthViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var isLoggedIn: Bool = false
    @Published var isLoading: Bool = false
    @Published var showLogIn: Bool = false
    @Published var errorMessage: String?
    
    private let service: AuthServiceProtocol
    
    /// Dependency Injection af service
    init(service: AuthServiceProtocol) {
        self.service = service
        self.user = service.currentUser
        self.isLoggedIn = user != nil
    }
    
    /// Logger brugeren ind ved hjælp af service.
    func signIn(email: String, password: String) async {
        isLoading = true
        defer { isLoading = false }
        do {
            let user = try await service.signin(email: email, password: password)
            self.user = user
            self.isLoggedIn = true
            self.showLogIn = false
        } catch {
            self.errorMessage = "Login failed: \(error.localizedDescription)"
        }
    }
    
    /// Logger brugeren ud ved hjælp af service.
    func signOut() {
        do {
            try service.signout()
            self.user = nil
            self.isLoggedIn = false
        } catch {
            self.errorMessage = "Sign out failed: \(error.localizedDescription)"
        }
    }
    
    /// Opretter bruger ved hjælp af service.
    func signUp(email: String, password: String) async {
        isLoading = true
        defer { isLoading = false }
        do {
            let user = try await service.signup(email: email, password: password)
            self.user = user
            self.isLoggedIn = true
            self.showLogIn = false
        } catch {
            self.errorMessage = "Sign up failed: \(error.localizedDescription)"
        }
    }
    
}
