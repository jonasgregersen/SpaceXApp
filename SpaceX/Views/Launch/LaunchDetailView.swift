//
//  LaunchDetailView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import SwiftUI
import MapKit

/// Dette View håndterer visning af alle relevate informationer for et launch.
/// Indeholder logik som sikrer at oplysninger kun vises hvis tilgængelig.
/// Indeholder en funktion for at tilgå launchpad lokation via kort, og muligheden for at tilføje launch til favorit.
struct LaunchDetailView: View {
    @EnvironmentObject var lpVM: LaunchPadViewModel
    @EnvironmentObject var userVM: UserFavoritesViewModel
    @EnvironmentObject var mapVM: MapViewModel
    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var favLaunchVM: FavoriteLaunchesViewModel
    var launch: Launch
    var body: some View {
            ScrollView {
                VStack {
                    SectionHeader(title: "Launch Info") // Basic information om launch
                    LaunchInfoView(launch: launch)
                        .padding()
                    
                    Divider()
                    
                    SectionHeader(title: "Rocket") // Detaljer om raketten
                    RocketInfoView(rocketId: launch.rocket)
                        .padding()
                    
                    Divider()
                    
                    if let payloads = launch.payloads, !payloads.isEmpty { // Payloads, som er klikbare i view'et.
                        SectionHeader(title: "Payload")
                        PayloadListView(payloadList: payloads)
                            .padding()
                        Divider()
                    }
                    
                    
                    if let capsules = launch.capsules, !capsules.isEmpty { // Basic capsule information
                        SectionHeader(title: "Capsules")
                        CapsuleListView(capsules: capsules)
                            .padding()
                        Divider()
                    }
                    
                    SectionHeader(title: "Launchpad") // Information om launchpad, og navigering til map lokation.
                    LaunchpadInfoView(launchpadId: launch.launchPad)
                        .padding()
                        .environmentObject(mapVM)
                    
                    Divider()
                    
                    // Liste over crewmembers.
                    if let crew = launch.crew, !crew.isEmpty {
                        SectionHeader(title: "Crew")
                        LaunchCrewView(crew: crew)
                            .padding()
                    }
                }
            }
            .padding()
            .navigationTitle("Launch details")
            .toolbar {
                if authVM.isLoggedIn { // Hvis logget ind, er det muligt at tilføje launch til favoritter.
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            Task { @MainActor in
                                await userVM.toggleFavorite(launch.id)
                                await favLaunchVM.reload(for: userVM.favoriteIds) // Da favorit launch listen er blevet opdateret, skal den genindlæses
                            }
                        } label: {
                            Image(systemName: userVM.isFavorite(launch.id) ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                    }
                }
            }
    }
}




