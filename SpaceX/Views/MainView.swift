//
//  MainView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import SwiftUI

// Dette View håndterer visning af forskellige tabs i applikationen. Dets formål er også at initialisere ViewModels med data, så det kan blive vist i SubViews.
struct MainView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var favVM: UserFavoritesViewModel
    @EnvironmentObject var tabVM: TabSelectionViewModel
    @EnvironmentObject var mapVM: MapViewModel
    @EnvironmentObject var landpadVM: LandingPadViewModel
    @EnvironmentObject var launchpadVM: LaunchPadViewModel
    @EnvironmentObject var favLaunchVM: FavoriteLaunchesViewModel
    @EnvironmentObject var launchVM: LaunchViewModel
    
    
    @State private var showLogIn: Bool = false // Bruges til login sheet view.
    
    var body: some View {
        // Selection her bruges til at kunne styre hvilket tab der vises fra en ViewModel.
        TabView(selection: $tabVM.selectedTab) {
            NavigationStack {
                MapView(launchpads: launchpadVM.allLaunchpads, landingpads: landpadVM.allLandingPads)
                    .sheet(isPresented: $showLogIn) {
                        NavigationStack {
                            LoginView()
                                .toolbar {
                                    ToolbarItem(placement: .topBarLeading) {
                                        Button("Back") {
                                            showLogIn = false
                                        }
                                    }
                                }
                        }
                    }
                    .navigationTitle("Pad Overview")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            if authVM.isLoggedIn {
                                Button("Sign out") {
                                    authVM.signOut()
                                }
                            } else {
                                Button("Log in") {
                                    showLogIn = true
                                }
                            }
                        }
                    }
                    .environmentObject(mapVM)
            }
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
                                    showLogIn = true
                                }
                            }
                            
                        }
                    }
                    .environmentObject(mapVM)
                    .onChange(of: authVM.isLoggedIn) { isLoggedIn in
                        if isLoggedIn {
                            showLogIn = false
                        }
                    }
            }
            .tabItem { Label("Launches", systemImage: "paperplane.fill") }
            .tag(1)
            .task {
                await launchVM.load()
            }
            if authVM.isLoggedIn { // Favorit tab kan kun vises, hvis logget ind.
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
