//
//  PayloadListView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import Foundation
import SwiftUI

// Dette View håndterer visning af en liste over payloads knyttet til et launch. Elementerne er klikbare, som redirigerer til PayLoadInfoView.
struct PayloadListView: View {
    @EnvironmentObject private var vm: PayloadViewModel
    let payloadList: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(vm.payloads) { payload in
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
        .onAppear {
            Task {
                await vm.load(payloadList)
            }
        }
    }
}
    
