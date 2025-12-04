//
//  CapsuleListView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import SwiftUI

struct CapsuleListView: View {
    @EnvironmentObject private var vm: CapsuleViewModel
    var capsules: [String]
    var body: some View {
        VStack(alignment: .leading) {
            if !vm.capsules.isEmpty {
                HStack {
                    VStack(spacing: 10) {
                        ForEach(vm.capsules) { capsule in
                            CapsuleRowView(capsule: capsule)
                        }
                    }
                    Spacer()
                    
                }
                
            }
        }
        .padding(.horizontal)
        .task {
            await vm.load(capsules)
        }
    }
}


#Preview {
    CapsuleListView(capsules: Launch.preview.capsules!)
}
