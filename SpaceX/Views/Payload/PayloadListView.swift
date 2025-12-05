//
//  PayloadListView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import Foundation
import SwiftUI

/// Viser en liste af payloads tilknyttet et launch.
/// Klik på et element navigerer til detaljevisning af payload.
struct PayloadListView: View {
    @EnvironmentObject private var vm: PayloadViewModel
    let payloadList: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(vm.payloads) { payload in
                // Vis hvert payload som klikbart kort med navn og type
                NavigationLink(destination: PayloadInfoView(payload: payload)) {
                    VStack(alignment: .leading) {
                        Text(payload.name)
                            .font(.headline)
                        
                        Text(payload.type)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color(.secondarySystemBackground)))
                    .padding(.vertical, 4)
                }
                
            }
        }
        // Indlæs payloads fra ViewModel når viewet vises
        .onAppear {
            Task {
                await vm.load(payloadList)
            }
        }
    }
}
    
