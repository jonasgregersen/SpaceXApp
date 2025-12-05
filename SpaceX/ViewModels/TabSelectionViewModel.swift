//
//  TabSelectionViewModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 04/12/2025.
//

import Foundation
import SwiftUI

// Bruges primært til at navigere til map fra "vis på kort" knap i LaunchpadInfoView.
class TabSelectionViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var showingLandingPadsTab: Bool = false // Hvis map picker er sat til show landingpads, skifter den til show launchpads ved tryk af "vis på kort" knap i LaunchpadInfoView.

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
