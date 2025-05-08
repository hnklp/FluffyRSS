//
//  SettingsScreen.swift
//  FluffyRSS
//
//  Created by Hynek Půta on 03/05/2025.
//

import SwiftUI

struct SettingsScreen: View {
    @AppStorage("appearanceMode") private var appearanceMode: String = "system" // Výchozí volba je "system"
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: AboutScreen()) {
                    Label("O aplikaci", systemImage: "info.circle")
                }

                Section(header: Text("Vzhled aplikace")) {
                    Picker("Režim vzhledu", selection: $appearanceMode) {
                        Text("Podle systému").tag("system")
                        Text("Světlý").tag("light")
                        Text("Tmavý").tag("dark")
                    }
                    .pickerStyle(SegmentedPickerStyle()) // Pro přehlednější volbu
                }
            }
            .navigationTitle("Nastavení")
        }
    }
}


