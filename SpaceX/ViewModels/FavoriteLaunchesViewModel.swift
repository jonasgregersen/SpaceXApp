//
//  FavoriteLaunchesViewModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 04/12/2025.
//

import Foundation

@MainActor
final class FavoriteLaunchesViewModel: ObservableObject {
    @Published var favoriteLaunches: [Launch] = []
    @Published var isLoading: Bool
    
    private let launchService: LaunchServiceProtocol
    
    init(service: LaunchServiceProtocol) {
        self.launchService = service
        self.isLoading = false
    }
    
    func loadLaunches(for ids: [String]) async {
        isLoading = true
        defer { isLoading = false }
        var launches: [Launch] = []
        
        await withTaskGroup(of: (Launch?).self) { group in
            for id in ids {
                group.addTask {
                    try? await self.launchService.getLaunchById(id)
                }
            }
            
            for await result in group {
                if let launch = result {
                    launches.append(launch)
                }
            }
        }
        
        favoriteLaunches = launches.sorted {$0.dateUTC > $1.dateUTC}
    }
}

