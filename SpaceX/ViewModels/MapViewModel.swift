//
//  MapViewModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 04/12/2025.
//

import Foundation
import MapKit

// Denne ViewModel håndterer Map funktioner, som visning af launches for en launchpad på kort og zoom ind på en valgt launchpad på kort.
@MainActor
final class MapViewModel: ObservableObject {
    @Published var showSheetForPad: MapPadItem? = nil // Viser et sheet med alle launches knyttet til                                                           det gemte Launchpad eller Landingpad.
    
    @Published var zoomToPad: LaunchPad? = nil // Gemt LaunchPad objekt, som bruges til at styre kortet i                                               zoom.
    
   // Gemte koordinater for den valgte launchpad. Som default er regionen et overblik over USA.
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 28.5, longitude: -80.6),
        span: MKCoordinateSpan(latitudeDelta: 60, longitudeDelta: 60))
    
    // Zoomer ind på den valgte launchpad på kortet.
    func zoom(to pad: LaunchPad) {
        Task { @MainActor in
            self.zoomToPad = pad
            self.region = MKCoordinateRegion( // Zoomer ind på den valgte launchpad på kortet.
                center: CLLocationCoordinate2D(latitude: pad.latitude, longitude: pad.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                )
            
            try? await Task.sleep(nanoseconds: 1_000_000) // Nulstiller den valgte launchpad efter 1 sekund.
            self.zoomToPad = nil
        }
    }
}
