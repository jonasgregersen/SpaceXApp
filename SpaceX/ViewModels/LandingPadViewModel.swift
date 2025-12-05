//
//  LandingpadViewModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 05/12/2025.
//

import Foundation

@MainActor
final class LandingPadViewModel: ObservableObject {
    @Published var landingPad: LandingPad? = nil
    @Published var allLandingPads: [LandingPad] = []
    
    var service: APIServiceProtocol
    
    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    func load(_ id: String) async {
        do {
            landingPad = try await service.fetch("landpads/\(id)")
        } catch {
            print("Der skete en fejl ved indlæsning af landpad: \(error.localizedDescription)")
        }
    }
    
    func loadAll() async {
        do {
            allLandingPads = try await service.fetch("landpads")
        } catch {
            print("Der skete en fejl ved indlæsning af alle landpads: \(error.localizedDescription)")
        }
    }
}
