//
//  ContentView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import SwiftUI
import FirebaseAuth
// Dette View initialiserer alle ViewModels, og injicerer dem ind i MainView, så de kan bruges globalt på applikationen.
struct ContentView: View {
    
    // Oprettelse af alle ViewModeller med service injiceret.
    @StateObject private var authVM = AuthViewModel(service: AuthService())
    @StateObject private var capsVM = CapsuleViewModel(service: APIService.shared)
    @StateObject private var crewVM = CrewViewModel(service: APIService.shared)
    @StateObject private var favLaunchVM = FavoriteLaunchesViewModel(service: APIService.LaunchService())
    @StateObject private var landpadVM = LandingPadViewModel(service: APIService.shared)
    @StateObject private var launchpadVM = LaunchPadViewModel(service: APIService.shared)
    @StateObject private var launchVM = LaunchViewModel(service: APIService.LaunchService())
    @StateObject private var mapVM = MapViewModel()
    @StateObject private var payloadVM = PayloadViewModel(service: APIService.shared)
    @StateObject private var rocketVM = RocketViewModel(service: APIService.shared)
    @StateObject private var tabVM = TabSelectionViewModel()
    @StateObject private var userVM = UserFavoritesViewModel(service: UserFavoritesService())

    
    var body: some View {
        // Videresend som environment objekter til MainView, så de kan tilgåes globalt.
            MainView()
                .environmentObject(authVM)
                .environmentObject(capsVM)
                .environmentObject(crewVM)
                .environmentObject(favLaunchVM)
                .environmentObject(landpadVM)
                .environmentObject(launchpadVM)
                .environmentObject(launchVM)
                .environmentObject(mapVM)
                .environmentObject(payloadVM)
                .environmentObject(rocketVM)
                .environmentObject(tabVM)
                .environmentObject(userVM)
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel(service: AuthService()))
        .environmentObject(CapsuleViewModel(service: APIService.shared))
        .environmentObject(CrewViewModel(service: APIService.shared))
        .environmentObject(FavoriteLaunchesViewModel(service: APIService.LaunchService()))
        .environmentObject(LaunchPadViewModel(service: APIService.shared))
        .environmentObject(LaunchViewModel(service: APIService.LaunchService()))
        .environmentObject(MapViewModel())
        .environmentObject(PayloadViewModel(service: APIService.shared))
        .environmentObject(RocketViewModel(service: APIService.shared))
        .environmentObject(TabSelectionViewModel())
        .environmentObject(UserFavoritesViewModel(service: UserFavoritesService()))
    
}
