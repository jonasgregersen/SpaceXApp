//
//  LaunchViewModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//
import Foundation
@MainActor

final class LaunchViewModel: ObservableObject {
    @Published var launches: [Launch] = []
    @Published var isLoading = false
    
    private let service: LaunchServiceProtocol
    
    init(service: LaunchServiceProtocol) {
        self.service = service
    }
    
    func load() async {
        isLoading = true
        defer {isLoading = false}
        
        do {
            let data = try await service.getLatestLaunches()
            print("Hentede \(data.count) launches.")
            launches = data.sorted { $0.dateUTC > $1.dateUTC }
        } catch {
            print("Kunne ikke hente launch oplysninger: \(error.localizedDescription)")
        }
    }

}
