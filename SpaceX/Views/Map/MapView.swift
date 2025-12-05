//
//  MapView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 04/12/2025.
//

import SwiftUI
import MapKit

// Bruges til at skifte imellem LaunchListView for launchpads eller landingpads, samt visning på kortet.
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

struct MapView: View {
    var launchpads: [LaunchPad]
    var landingpads: [LandingPad]
    @EnvironmentObject private var launchVM: LaunchViewModel
    @EnvironmentObject private var mapVM: MapViewModel
    @EnvironmentObject private var tabVM: TabSelectionViewModel
    
    var body: some View {
        VStack {
            Picker("Pads", selection: $tabVM.showingLandingPadsTab) {
                Text("Launch Pads").tag(false)
                Text("Landing Pads").tag(true)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            if !tabVM.showingLandingPadsTab {
                Map(coordinateRegion: $mapVM.region, annotationItems: launchpads, annotationContent: { pad in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: pad.latitude, longitude: pad.longitude)) {
                        Button {
                            mapVM.showSheetForPad = .launch(pad) // Vis sheet for en given pad, uanset om det er launchpad eller landingpad.
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
        .onChange(of: mapVM.zoomToPad) { pad in
            guard let pad = pad else {return}
            mapVM.region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: pad.latitude, longitude: pad.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
        }
    }
}


