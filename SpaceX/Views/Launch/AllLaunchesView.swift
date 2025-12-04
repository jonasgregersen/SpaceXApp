//
//  LaunchListView.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import SwiftUI

struct AllLaunchesView: View {
    @EnvironmentObject private var launchVM: LaunchViewModel
    @State private var path = NavigationPath()
    var body: some View {
            NavigationStack(path: $path) {
                
        }
    }
}

#Preview {
    AllLaunchesView()
}
