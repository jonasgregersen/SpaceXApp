//
//  SpaceXApp.swift
//  SpaceX
//
//  Created by Jonas Gregersen on 01/12/2025.
//

import SwiftUI
import Firebase

/// Klassen håndterer konfigurering af Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct SpaceXApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
    WindowGroup {
      NavigationView {
        ContentView()
              .preferredColorScheme(.dark)
              .background(Color.black)
      }
    }
  }
}
