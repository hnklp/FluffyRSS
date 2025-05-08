//
//  AboutScreen.swift
//  FluffyRSS
//
//  Created by Hynek Půta on 03/05/2025.
//

import SwiftUI

struct AboutScreen: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Verze 1.0")
                .foregroundColor(.secondary)

            Text("Tato jednoduchá aplikace slouží ke čtení RSS. Byla vytvořena jako jednoduchý projekt pro předmět KI/PMP.")
            
            Spacer()
        }
        .padding()
        .navigationTitle("FluffyRSS")
    }
}
