//
//  MainView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import SwiftUI

/// Hovedview med tab-navigation mellem Map, Launches og Favorites.
/// Initialiserer og leverer ViewModels til underliggende Views.
struct MainView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var favVM: UserFavoritesViewModel
    @EnvironmentObject var tabVM: TabSelectionViewModel
    @EnvironmentObject var mapVM: MapViewModel
    @EnvironmentObject var landpadVM: LandingPadViewModel
    @EnvironmentObject var launchpadVM: LaunchPadViewModel
    @EnvironmentObject var favLaunchVM: FavoriteLaunchesViewModel
    @EnvironmentObject var launchVM: LaunchViewModel
    
    var body: some View {
        // TabView med navigation og dynamisk login-sheet
        TabView(selection: $tabVM.selectedTab) {
            NavigationStack {
                MapView(launchpads: launchpadVM.allLaunchpads, landingpads: landpadVM.allLandingPads)
                // Sheet til login, vises når brugeren trykker "Log in"
                    .sheet(isPresented: $authVM.showLogIn) {
                        NavigationStack {
                            LoginView()
                                .toolbar {
                                    ToolbarItem(placement: .topBarLeading) {
                                        Button("Back") {
                                            authVM.showLogIn = false
                                        }
                                    }
                                }
                        }
                    }
                    .navigationTitle("Pad Overview")
                    .toolbar {
                        // Viser Log in/Sign out knap afhængigt af login-status
                        ToolbarItem(placement: .topBarTrailing) {
                            if authVM.isLoggedIn {
                                Button("Sign out") {
                                    authVM.signOut()
                                }
                            } else {
                                Button("Log in") {
                                    authVM.showLogIn = true
                                }
                            }
                        }
                    }
                    .environmentObject(mapVM)
            }
            // Indlæs data for map (launchpads og landingpads)
            .task {
                await launchpadVM.loadAll()
                await landpadVM.loadAll()
            }
            .tabItem { Label("Map", systemImage: "map")}
            .tag(0)
            
            // Listview over alle launches
            NavigationStack {
                AllLaunchesView()
                    .navigationTitle("Launches")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            if authVM.isLoggedIn {
                                Button("Sign out") {
                                    authVM.signOut()
                                }
                            } else {
                                Button("Log in") {
                                    authVM.showLogIn = true
                                }
                            }
                            
                        }
                    }
                    .environmentObject(mapVM)
                    .onChange(of: authVM.isLoggedIn) { isLoggedIn in
                        if isLoggedIn {
                            authVM.showLogIn = false
                        }
                    }
            }
            .tabItem { Label("Launches", systemImage: "paperplane.fill") }
            .tag(1)
            // Indlæs alle launches
            .task {
                await launchVM.load()
            }
            // Favorit-tab vises kun for indloggede brugere
            if authVM.isLoggedIn {
                NavigationStack {
                    FavoriteLaunchesView()
                        .navigationTitle("Favorites")
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button("Sign out") {
                                    authVM.signOut()
                                }
                            }
                        }
                        .environmentObject(mapVM)
                }
                .tabItem { Label("Favorites", systemImage: "star.fill") }
                .tag(2)
            }
            
        }
    }
}


#Preview {
    MainView()
        .environmentObject(AuthViewModel(service: AuthService()))
        .environmentObject(UserFavoritesViewModel(service: UserFavoritesService()))
}
