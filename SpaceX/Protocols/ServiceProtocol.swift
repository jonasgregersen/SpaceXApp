//
//  ServiceProtocol.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 04/12/2025.
//

import Foundation
import FirebaseAuth

/// Protokoller til services for at sikre dekobling mellem ViewModels og backend/API.
///
/// Service protokol for Launch relaterede API kald
protocol LaunchServiceProtocol {
    func getAllLaunches() async throws -> [Launch]
    func getLaunchById(_ id: String) async throws -> Launch
    func idsToLaunchArray(_ ids: [String]) async throws -> [Launch]
}

/// Service protokol for brugerens favoritter
protocol UserFavoritesServiceProtocol {
    func loadFavorites() async throws -> [String]
    func addFavorite(_ id: String) async throws
    func removeFavorite(_ id: String) async throws
}

/// Service protokol for autentifikation
protocol AuthServiceProtocol {
    var currentUser: User? { get }
    func signin(email: String, password: String) async throws -> User
    func signup(email: String, password: String) async throws -> User
    func signout() throws
}

/// Generisk API service protokol til at hente data fra endpoints
protocol APIServiceProtocol {
    func fetch<T: Decodable>(_ endpoint: String) async throws -> T
    func fetch<T: Decodable>(_ url: URL) async throws -> T
}

