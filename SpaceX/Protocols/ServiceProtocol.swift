//
//  ServiceProtocol.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 04/12/2025.
//

import Foundation
import FirebaseAuth

// Protokoller til ViewModels: dekopling.
protocol LaunchServiceProtocol {
    func getLatestLaunches() async throws -> [Launch]
    func getLaunchById(_ id: String) async throws -> Launch
}

protocol UserFavoritesServiceProtocol {
    func loadFavorites() async throws -> [String]
    func addFavorite(_ id: String) async throws
    func removeFavorite(_ id: String) async throws
}

protocol AuthServiceProtocol {
    var currentUser: User? { get }
    func signin(email: String, password: String) async throws -> User
    func signup(email: String, password: String) async throws -> User
    func signout() throws
}

protocol APIServiceProtocol {
    func fetch<T: Decodable>(_ endpoint: String) async throws -> T
    func fetch<T: Decodable>(_ url: URL) async throws -> T
}

