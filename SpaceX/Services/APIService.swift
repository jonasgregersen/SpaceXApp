//
//  FetchService.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import Foundation

final class APIService: APIServiceProtocol {
    
    // Singleton APIService instans, sikrer at der kun findes én instans.
    static let shared = APIService()
    
    func fetch<T: Decodable>(_ endpoint: String) async throws -> T {
        let url = URL(string: "https://api.spacexdata.com/v4/\(endpoint)")!
        return try await fetch(url)
    }
    
    func fetch<T: Decodable>(_ url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601WithFractionalSeconds
        return try decoder.decode(T.self, from: data)
    }
    
    struct LaunchService: LaunchServiceProtocol {
        private let launchUrl = URL(string:"https://api.spacexdata.com/v5/launches")!
        
        func getLatestLaunches() async throws -> [Launch] {
            try await APIService.shared.fetch(launchUrl)
        }
        func getLaunchById(_ id: String) async throws -> Launch {
            let launchURL = URL(string: "https://api.spacexdata.com/v5/launches/\(id)")!
            return try await APIService.shared.fetch(launchURL)
        }
    }
}

