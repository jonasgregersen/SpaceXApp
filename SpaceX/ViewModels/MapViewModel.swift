//
//  MapViewModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 04/12/2025.
//

import Foundation
import MapKit

@MainActor
final class MapViewModel: ObservableObject {
    @Published var showSheetForPad: MapPadItem? = nil
    @Published var zoomToPad: LaunchPad? = nil
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 28.5, longitude: -80.6),
        span: MKCoordinateSpan(latitudeDelta: 60, longitudeDelta: 60))
    
    func zoom(to pad: LaunchPad) {
        Task { @MainActor in
            self.zoomToPad = pad
            self.region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: pad.latitude, longitude: pad.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                )
        }
    }
}
