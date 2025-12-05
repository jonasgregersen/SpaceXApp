//
//  MapView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import SwiftUI
import MapKit

/// Vis detaljer for en launchpad og giver mulighed for at zoome ind på kortet.
struct LaunchpadInfoView: View {
    @EnvironmentObject private var vm: LaunchPadViewModel
    @EnvironmentObject private var mapVM: MapViewModel
    @EnvironmentObject private var tabVM: TabSelectionViewModel

    var launchpadId: String
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Kort
                if let pad = vm.launchpad {
                    
                    // Skifter til map-tab og zoomer ind på den valgte launchpad.
                    Button("View on map") {
                        mapVM.zoom(to: pad)
                        mapVM.showSheetForPad = nil // Hvis navigering sker fra sheet'et inde fra map tab, lukkes sheet'et ned, så map kommer i fokus.
                        tabVM.showingLandingPadsTab = false // Tvinger map picker til at vise launchpads, så vi ikke zoomer ind på et tomt sted under landingpads.
                        tabVM.goToMapTab()
                    }
                    
                    // Viser launchpad-navn, type, lokation, status og opsendelsesstatistik.
                    Text(pad.full_name)
                        .font(.title2)
                        .bold()
                        .padding(.horizontal)
                    
                    if let details = pad.details {
                        Text(details)
                            .padding(.horizontal)
                    }
                    
                    Text("Location: \(pad.locality), \(pad.region)")
                        .padding(.horizontal)
                    
                    if let status = pad.status {
                        Text("Status: \(status)")
                            .padding(.horizontal)
                    }
                    
                    Text("Successful launches: \(pad.launch_successes)")
                        .padding(.horizontal)
                    
                    Text("Failed launches: \(pad.launch_attempts - pad.launch_successes)")
                        .padding(.horizontal)
                    
                    
                } else {
                    // Loading indikator mens launchpad-data indlæses
                    ProgressView("Loading launchpad...")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .task {
            await vm.load(launchpadId)
        }
    }
}






