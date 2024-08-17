//
//  SettingView.swift
//  Meally
//
//  Created by Brwerx on 8/16/24.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            // Other tabs
            Text("Settings content here") // Replace with actual settings content
            
            FavoritesView() // Add the Favorites tab here
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
    }
}
