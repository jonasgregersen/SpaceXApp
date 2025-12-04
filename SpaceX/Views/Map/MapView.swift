//
//  MapView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 04/12/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    var launchpads: [Launchpad]
    @EnvironmentObject private var launchVM: LaunchViewModel
    @EnvironmentObject private var mapVM: MapViewModel
    
    var body: some View {
        Map(coordinateRegion: $mapVM.region, annotationItems: launchpads, annotationContent: { pad in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: pad.latitude, longitude: pad.longitude)) {
                Button {
                    mapVM.showSheetForPad = pad
                } label: {
                    VStack {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title)
                            .foregroundColor(.red)
                        Text(pad.name)
                            .font(.caption)
                            .fixedSize()
                    }
                }
            }
        })
        .sheet(item: $mapVM.showSheetForPad) { pad in
            let padLaunches = launchVM.launches.filter { $0.launchPad == pad.id }
            NavigationStack {
                LaunchListView(launches: padLaunches, title: "Launches for \(pad.name)")
                    .environmentObject(mapVM)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Back") {
                                mapVM.showSheetForPad = nil
                            }
                        }
                    }
                    .task {
                        await launchVM.load()
                    }
            }
            
        }
        .onChange(of: mapVM.zoomToPad) { pad in
            guard let pad = pad else {return}
            mapVM.region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: pad.latitude, longitude: pad.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
            
        }
    }
}


