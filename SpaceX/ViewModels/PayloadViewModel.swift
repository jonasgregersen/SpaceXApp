//
//  PayloadViewModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import Foundation

// Denne ViewModel har samme struktur som CapsuleViewModel, henter PayLoad data for et launch.
@MainActor
final class PayloadViewModel: ObservableObject {
    @Published var payloads: [Payload] = []
    
    var service: APIServiceProtocol
    
    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    // Henter en liste af payloads fra payloadlist i launch.
    func load(_ payloadList: [String]) async {
        var localPayloads: [Payload] = []
        
        for item in payloadList {
            do {
                let payload: Payload = try await APIService.shared.fetch("payloads/\(item)")
                localPayloads.append(payload)
            } catch {
                print("Kunne ikke hente payload: \(error.localizedDescription)")
            }
        }
        print("Fandt \(localPayloads.count) payloads.")
        payloads = localPayloads
    }
}
