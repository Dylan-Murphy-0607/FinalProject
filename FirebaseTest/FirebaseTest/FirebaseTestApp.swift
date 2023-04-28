//
//  FirebaseTestApp.swift
//  FirebaseTest
//
//  Created by Dylan Murphy on 4/27/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}



@main
struct FirebaseTestApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var eventsVM = EventViewModel()
    @StateObject var locationVM = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(eventsVM)
                .environmentObject(locationVM)
        }
    }
}
