//
//  TabSelectionViewModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 04/12/2025.
//

import Foundation
import SwiftUI

class TabSelectionViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var showingLandingPadsTab: Bool = false

    func goToMapTab() {
        selectedTab = 0
    }

    func goToLaunchesTab() {
        selectedTab = 1
    }

    func goToFavoritesTab() {
        selectedTab = 2
    }
}
