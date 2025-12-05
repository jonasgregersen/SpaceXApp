//
//  FetchService.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import Foundation

/// APIService håndterer alle asynkrone HTTP kald til SpaceX API'et.
/// Indeholder generiske fetch metoder og en specialiseret LaunchService.
final class APIService: APIServiceProtocol {
    
    // Singleton instans, sikrer at der kun findes én instans af APIService
    static let shared = APIService()
    
    // Generisk fetch metode for endpoints til hardcoded url for API'en.
    func fetch<T: Decodable>(_ endpoint: String) async throws -> T {
        let url = URL(string: "https://api.spacexdata.com/v4/\(endpoint)")!
        return try await fetch(url)
    }
    
    // Generisk fetch metode for en given URL med dateDecoding.
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
    
    /// Specialiseret service til håndtering af launches
    /// Indeholder metoder som ikke passer ind i den generiske fetch
    struct LaunchService: LaunchServiceProtocol {
        private let launchUrl = URL(string:"https://api.spacexdata.com/v5/launches")!
        
        // Hent alle launches
        func getAllLaunches() async throws -> [Launch] {
            try await APIService.shared.fetch(launchUrl)
        }
        
        // Konverter en liste af id'er til en liste af launches
        func idsToLaunchArray(_ ids: [String]) async throws -> [Launch] {
            var launchArray: [Launch] = []
            
            for id in ids {
                try launchArray.append(await getLaunchById(id))
            }
            
            return launchArray
        }
        
        // Hent en launch ud fra ID
        func getLaunchById(_ id: String) async throws -> Launch {
            let launchURL = URL(string: "https://api.spacexdata.com/v5/launches/\(id)")!
            return try await APIService.shared.fetch(launchURL)
        }
    }
}

