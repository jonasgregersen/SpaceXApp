//
//  PayloadListView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import Foundation
import SwiftUI

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
    
