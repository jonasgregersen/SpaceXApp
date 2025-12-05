//
//  TabSelectionViewModel.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 04/12/2025.
//

import Foundation
import SwiftUI

/// Denne ViewModel håndterer tabvisning og navigering.
/// Dens primære funktion er at redirigere view'et til kortet ved klik på "Show on map" i LaunchpadInfoView.
class TabSelectionViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
    /// Hvis map picker er sat til show landingpads, skifter den til show launchpads ved tryk af "vis på kort" knap i LaunchpadInfoView.
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
