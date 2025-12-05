//
//  RocketViewModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import Foundation

@MainActor
class RocketViewModel: ObservableObject {
    @Published var rocket: Rocket? = nil
    
    var service: APIServiceProtocol
    
    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    // Henter raketten, som er knyttet til launch.
    func load(_ rocketId: String) async {
        do {
            rocket = try await service.fetch("rockets/\(rocketId)")
        } catch {
            print("Der skete en fejl ved hentning af launchpad: \(error.localizedDescription)")
        }
    }
}
