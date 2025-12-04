//
//  CrewViewModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import Foundation
import SwiftUI

@MainActor
class CrewViewModel: ObservableObject {
    @Published var crewMembers: [(CrewMember, String)] = [] // (medlem, rolle)
    
    var service: APIServiceProtocol
    
    init(service: APIServiceProtocol) {
        self.service = service
    }
    
    func load(_ crewList: [Crew]) async {
        var members: [(CrewMember, String)] = []
        
        for crew in crewList {
            do {
                let member: CrewMember = try await service.fetch("crew/\(crew.crew)")
                members.append((member, crew.role))
            } catch {
                print("Fejl ved hentning af crew: \(error)")
            }
        }
        print("Fandt \(crewList.count) crew members.")
        self.crewMembers = members
    }
}


