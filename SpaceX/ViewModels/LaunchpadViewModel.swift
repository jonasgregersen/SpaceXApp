//
//  LaunchpadViewModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import Foundation

@MainActor
class LaunchpadViewModel: ObservableObject {
    @Published var launchpad: Launchpad? = nil
    @Published var allLaunchpads: [Launchpad] = []
    
    var service: APIServiceProtocol
    
    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    func load(_ launchpadId: String) async {
        do {
            launchpad = try await service.fetch("launchpads/\(launchpadId)")
        } catch {
            print("Der skete en fejl ved hentning af launchpad: \(error.localizedDescription)")
        }
    }
    func loadAll() async {
        do {
            allLaunchpads = try await service.fetch("launchpads")
        } catch {
            print("Der skete en fejl ved hentning af alle launchpads: \(error.localizedDescription)")
        }
    }
}
