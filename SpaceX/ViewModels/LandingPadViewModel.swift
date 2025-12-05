//
//  LandingpadViewModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 05/12/2025.
//

import Foundation

// Denne ViewModel afviger fra de andre ViewModels med sin indlæsningmetode, da den henter alle landing pad objekter i API'et, dog er formålet det samme som CapsuleViewModel.
@MainActor
final class LandingPadViewModel: ObservableObject {
    @Published var allLandingPads: [LandingPad] = []
    
    var service: APIServiceProtocol
    
    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    // Indlæser alle landingpads i API'et.
    func loadAll() async {
        do {
            allLandingPads = try await service.fetch("landpads")
        } catch {
            print("Der skete en fejl ved indlæsning af alle landpads: \(error.localizedDescription)")
        }
    }
}
