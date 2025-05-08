//
//  ContentView.swift
//  FluffyRSS
//
//  Created by Hynek Půta on 29/04/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var feedViewModel = FeedViewModel()

    var body: some View {
        TabView {
            FeedScreen(feedViewModel: feedViewModel)
                .tabItem {
                    Label("Feed", systemImage: "newspaper")
                }

            SourcesScreen(feedViewModel: feedViewModel)
                .tabItem {
                    Label("Zdroje", systemImage: "dot.radiowaves.left.and.right")
                }

            SettingsScreen()
                .tabItem {
                    Label("Nastavení", systemImage: "gear")
                }
        }
    }
}
