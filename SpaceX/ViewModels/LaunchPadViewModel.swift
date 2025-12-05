//
//  LaunchpadViewModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import Foundation

@MainActor
class LaunchPadViewModel: ObservableObject {
    @Published var launchpad: LaunchPad? = nil
    @Published var allLaunchpads: [LaunchPad] = []
    
    var service: APIServiceProtocol
    
    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    // Indlæser et enkelt launchpad ud fra dets id.
    func load(_ launchpadId: String) async {
        do {
            launchpad = try await service.fetch("launchpads/\(launchpadId)")
        } catch {
            print("Der skete en fejl ved hentning af launchpad: \(error.localizedDescription)")
        }
    }
    
    // Indlæser alle launchpads fra API'et.
    func loadAll() async {
        do {
            allLaunchpads = try await service.fetch("launchpads")
        } catch {
            print("Der skete en fejl ved hentning af alle launchpads: \(error.localizedDescription)")
        }
    }
}
