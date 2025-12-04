//
//  MapView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var vm = LaunchpadViewModel()
    var launchpadId: String

    var body: some View {
        VStack {
            Text("Launchpad location")
                .font(.headline)
                .bold()
                .padding()

            if let pad = vm.launchpad {
                let coordinates = CLLocationCoordinate2D(latitude: pad.latitude, longitude: pad.longitude)
                
                Map(initialPosition: .region(
                    MKCoordinateRegion(
                        center: coordinates,
                        span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
                    )
                )) {
                    Marker(pad.name, coordinate: coordinates)
                }
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding()
            } else {
                ProgressView("Loading launchpad...")
            }
        }
        .task {
            await vm.load(launchpadId)
        }
    }
}




