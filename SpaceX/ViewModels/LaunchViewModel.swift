//
//  LaunchViewModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//
import Foundation

//Denne ViewModel's struktur er den samme som FavoriteLaunchViewModel, bare Launches ikke er baseret på user favorites, men hele API'et.
@MainActor
final class LaunchViewModel: ObservableObject {
    @Published var launches: [Launch] = []
    @Published var isLoading = false
    private var hasLoaded = false
    
    private let service: LaunchServiceProtocol
    
    init(service: LaunchServiceProtocol) {
        self.service = service
    }
    
    // Henter alle launches fra API'et og sætter launches variabel til de launches.
    func load() async {
        guard !hasLoaded else { return } // Hvis launches er loaded, kør ikke metoden.
        isLoading = true
        defer {isLoading = false} // Køres efter metoden er færdigkørt
        
        do {
            let data = try await service.getAllLaunches()
            print("Hentede \(data.count) launches.")
            launches = data.sorted { $0.dateUTC > $1.dateUTC }
            hasLoaded = true
        } catch {
            print("Kunne ikke hente launch oplysninger: \(error.localizedDescription)")
        }
    }
    
    // Genindlæsning af launches fra API
    func reload() async {
        hasLoaded = false
        await load()
    }

}
