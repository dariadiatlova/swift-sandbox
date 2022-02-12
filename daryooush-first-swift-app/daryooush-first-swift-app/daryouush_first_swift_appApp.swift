//
//  daryouush_first_swift_appApp.swift
//  daryouush-first-swift-app
//
//  Created by Daria on 19.01.2022.
//

import SwiftUI

@main
struct daryooush_first_swift_appApp: App {
    @StateObject var locations = Locations()
    
    var body: some Scene {
        WindowGroup {
            TabView{
            NavigationView {
                ContentView(location: locations.secondary)
            }
            .tabItem{
                Image(systemName: "airplane.circle.fill")
                Text("Discover")
            }
            NavigationView {
                WorldView()
            }
            .tabItem {
                Image(systemName: "star.fill")
                Text("Locations")
            }
          }
          .environmentObject(locations)
        }
    }
}
