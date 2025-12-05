//
//  LaunchDetailView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import SwiftUI
import MapKit

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
                    SectionHeader(title: "Launch Info")
                    LaunchInfoView(launch: launch)
                        .padding()
                    
                    Divider()
                    
                    SectionHeader(title: "Rocket")
                    RocketInfoView(rocketId: launch.rocket)
                        .padding()
                    
                    Divider()
                    
                    if let payloads = launch.payloads, !payloads.isEmpty {
                        SectionHeader(title: "Payload")
                        PayloadListView(payloadList: payloads)
                            .padding()
                        Divider()
                    }
                    
                    
                    if let capsules = launch.capsules, !capsules.isEmpty {
                        SectionHeader(title: "Capsules")
                        CapsuleListView(capsules: capsules)
                            .padding()
                        Divider()
                    }
                    
                    SectionHeader(title: "Launchpad")
                    LaunchpadInfoView(launchpadId: launch.launchPad)
                        .padding()
                        .environmentObject(mapVM)
                    
                    Divider()
                    
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
                if authVM.isLoggedIn {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            Task { @MainActor in
                                await userVM.toggleFavorite(launch.id)
                                favLaunchVM.reload()
                                await favLaunchVM.loadLaunches(for: userVM.favoriteIds)
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




