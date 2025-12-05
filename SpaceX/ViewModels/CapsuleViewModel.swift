//
//  CapsuleViewModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import Foundation
import SwiftUI

/// ViewModel der håndterer indlæsning af SpaceX capsules via et asynkront API-kald.
/// Initialiseres med en service, der følger APIServiceProtocol.
@MainActor
class CapsuleViewModel: ObservableObject {
    @Published var capsules: [Capsule] = []
    
    var service: APIServiceProtocol
    
    /// Dependency Injection af service
    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    /// Loader alle capsules ud fra en liste af capsuleID’er.
    /// Henter hver capsule individuelt fra API’et og opdaterer capsules når alle kald er færdige.
    func load(_ capsuleList: [String]) async {
        var localCapsules: [Capsule] = []
        for capsule in capsuleList {
            do {
                let item: Capsule = try await service.fetch("capsules/\(capsule)")
                localCapsules.append(item)
            } catch {
                print("Der skete en fejl ved hentning af capsules: \(error.localizedDescription)")
            }
        }
        print("Fandt \(capsuleList.count) capsules.")
        self.capsules = localCapsules
    }
}


