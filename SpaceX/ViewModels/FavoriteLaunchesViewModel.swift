//
//  FavoriteLaunchesViewModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 04/12/2025.
//

import Foundation

/// ViewModel der håndterer favorit launches for UserFavoritesViewModel.
/// Denne ViewModels ansvar er at decode launchId's fra UserFavoritesViewModel til brugbare Launch objekter, som gemmes på ViewModel til brug.
/// Anvender Dependency Injection som de andre ViewModels, dog for services der følger LaunchServiceProtocol
@MainActor
final class FavoriteLaunchesViewModel: ObservableObject {
    @Published var favoriteLaunches: [Launch] = []
    @Published var isLoading: Bool /// Sikrer at brugeren bliver informeret om at indlæsning er ved at ske.
    private var hasLoaded = false /// Sikrer at hvis userens favorit launches ikke er opdateret, skal favorit launches ikke genindlæses.
    
    private let launchService: LaunchServiceProtocol
    
    init(service: LaunchServiceProtocol) {
        self.launchService = service
        self.isLoading = false
    }
    
    func loadLaunches(for ids: [String]) async {
        guard !hasLoaded else { return } /// Hvis favorit launches er indlæst i forvejen uden ændringer, skal
                                        ///de ikke læses ind igen.
        isLoading = true
        defer { isLoading = false } /// Køres efter metoden er færdigkørt.
        var launches: [Launch]
        do {
            launches = try await self.launchService.idsToLaunchArray(ids)
            launches = launches.sorted { $0.dateUTC > $1.dateUTC } /// Sorterer launches efter dato, nyeste                                                                                                                                                     først.
            favoriteLaunches = launches
            hasLoaded = true
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func reload(for ids: [String]) async {
        hasLoaded = false
        await loadLaunches(for: ids)
    }
}

