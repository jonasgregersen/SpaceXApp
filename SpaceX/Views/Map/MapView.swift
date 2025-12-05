//
//  MapView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 04/12/2025.
//

import SwiftUI
import MapKit

/// Repræsenterer et kort-element (launchpad eller landingpad) med id, navn og koordinater.
enum MapPadItem: Identifiable {
    case launch(LaunchPad)
    case landing(LandingPad)
    
    var id: String {
        switch self {
        case .launch(let pad): return pad.id
        case .landing(let pad): return pad.id
        }
    }
    
    var name: String {
        switch self {
        case .launch(let pad): return pad.name
        case .landing(let pad): return pad.name
        }
    }
    
    var latitude: Double {
        switch self {
        case .launch(let pad): return pad.latitude
        case .landing(let pad): return pad.latitude
        }
    }
    
    var longitude: Double {
        switch self {
        case .launch(let pad): return pad.longitude
        case .landing(let pad): return pad.longitude
        }
    }
}

/// Visning af kort med launchpads og landingpads.
/// Picker skifter mellem typer, klik på pin viser tilhørende launches i sheet.
struct MapView: View {
    var launchpads: [LaunchPad]
    var landingpads: [LandingPad]
    @EnvironmentObject private var launchVM: LaunchViewModel
    @EnvironmentObject private var mapVM: MapViewModel
    @EnvironmentObject private var tabVM: TabSelectionViewModel
    
    var body: some View {
        VStack {
            // Vælger mellem launchpads og landingpads
            Picker("Pads", selection: $tabVM.showingLandingPadsTab) {
                Text("Launch Pads").tag(false)
                Text("Landing Pads").tag(true)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if !tabVM.showingLandingPadsTab {
                Map(coordinateRegion: $mapVM.region, annotationItems: launchpads, annotationContent: { pad in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: pad.latitude, longitude: pad.longitude)) {
                        // Klik på pin åbner sheet med launches for den valgte pad
                        Button {
                            mapVM.showSheetForPad = .launch(pad)
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
            } else {
                Map(coordinateRegion: $mapVM.region, annotationItems: landingpads, annotationContent: { pad in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: pad.latitude, longitude: pad.longitude)) {
                        Button {
                            mapVM.showSheetForPad = .landing(pad)
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
            }
        }
        // Viser liste over launches tilknyttet den valgte pad
        .sheet(item: $mapVM.showSheetForPad) { pad in
            let padLaunches: [Launch] = {
                    switch pad {
                    case .launch(let launchPad):
                        return launchVM.launches.filter { $0.launchPad == launchPad.id }
                    case .landing(let landingPad):
                        return launchVM.launches.filter { landingPad.launches.contains($0.id) }
                    }
                }()
            NavigationStack {
                LaunchListView(launches: padLaunches, title: "Launches for \(pad.name)")
                    .task {
                        await launchVM.load()
                    }
            }
        }
        // Zoomer kortet ind, når zoomToPad ændres
        .onChange(of: mapVM.zoomToPad) { pad in
            guard let pad = pad else {return}
            mapVM.region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: pad.latitude, longitude: pad.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
        }
    }
}


