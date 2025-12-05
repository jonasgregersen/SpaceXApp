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
    private var hasLoaded = false
    
    private let launchService: LaunchServiceProtocol
    
    init(service: LaunchServiceProtocol) {
        self.launchService = service
        self.isLoading = false
    }
    
    func loadLaunches(for ids: [String]) async {
        guard !hasLoaded else { return }
        isLoading = true
        defer { isLoading = false }
        var launches: [Launch]
        do {
            launches = try await self.launchService.idsToLaunchArray(ids)
            launches = launches.sorted { $0.dateUTC > $1.dateUTC }
            favoriteLaunches = launches
            hasLoaded = true
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func reload() {
        hasLoaded = false
    }
}

