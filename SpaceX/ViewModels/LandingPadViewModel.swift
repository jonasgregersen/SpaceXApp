//
//  LandingpadViewModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 05/12/2025.
//

import Foundation

@MainActor
final class LandingPadViewModel: ObservableObject {
    @Published var allLandingPads: [LandingPad] = []
    
    var service: APIServiceProtocol
    
    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    func loadAll() async {
        do {
            allLandingPads = try await service.fetch("landpads")
        } catch {
            print("Der skete en fejl ved indlæsning af alle landpads: \(error.localizedDescription)")
        }
    }
}
