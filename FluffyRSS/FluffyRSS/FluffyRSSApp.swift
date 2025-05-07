//
//  FeedViewModel.swift
//  FluffyRSS
//
//  Created by Hynek Půta on 28/04/2025.
//

import SwiftUI

@main
struct RssReaderApp: App {
    @AppStorage("appearanceMode") private var appearanceMode: String = "system" // Výchozí volba je "system"
    
    // Podmíněně nastavíme vzhled podle uživatelovy volby
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(getColorScheme()) // Nastavení vzhledu na základě volby uživatele
        }
    }
    
    private func getColorScheme() -> ColorScheme? {
        switch appearanceMode {
        case "dark":
            return .dark
        case "light":
            return .light
        default:
            return nil // Systémový režim
        }
    }
}
