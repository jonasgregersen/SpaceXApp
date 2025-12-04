//
//  LaunchDetailView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import SwiftUI
import MapKit

struct LaunchDetailView: View {
    @StateObject var lpVM = LaunchpadViewModel()
    var launch: Launch
    var body: some View {
            ScrollView {
                VStack {
                    LaunchInfoView(launch: launch)
                        .padding()
                    if let crew = launch.crew {
                        CrewView(crew: crew)
                    }
                    if let launchPad = lpVM.launchpad {
                        MapView(pad: launchPad)
                    }
                    if let capsules = launch.capsules {
                        CapsuleListView(capsuleList: capsules)
                    }
                }
                .task {
                    await lpVM.loadLaunchpad(launch.launchPad)
                }
            }
            .padding()
            .navigationTitle("Launch details")
    }
}

#Preview {
    LaunchDetailView(launch: Launch.preview)
        .scaledToFit()
}


