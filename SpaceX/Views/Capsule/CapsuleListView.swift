//
//  CapsuleListView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 02/12/2025.
//

import SwiftUI

struct CapsuleListView: View {
    @StateObject private var vm = CapsuleViewModel()
    var capsuleList: [String]
    var body: some View {
        NavigationStack() {
            List(vm.capsules) {
                capsule in
                NavigationLink(value: capsule) {
                    CapsuleRowView(capsule: capsule)
                }
            }
            .navigationDestination(for: Capsule.self) { capsule in CapsuleDetailView(capsule: capsule)
            }
            .navigationTitle("Capsules")
            .task {
                await vm.loadCapsules(capsuleList)
            }
        }
    }
}

#Preview {
    CapsuleListView(capsuleList: Launch.preview.capsules!)
}
