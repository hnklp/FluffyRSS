//
//  SettingsScreen.swift
//  FluffyRSS
//
//  Created by Hynek Půta on 29/04/2025.
//

import SwiftUI

struct SourcesScreen: View {
    @ObservedObject var feedViewModel: FeedViewModel
    @State private var newSource: String = ""
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Přidat nový zdroj", text: $newSource)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button {
                        feedViewModel.addSource(newSource)
                        newSource = ""
                        if feedViewModel.errorMessage != nil {
                            showAlert = true
                        }
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.title2)
                    }
                }
                .padding()

                List {
                    ForEach(feedViewModel.savedSources, id: \.self) { source in
                        Text(source)
                            .padding(.vertical, 8)
                    }
                    .onDelete(perform: deleteSource)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Zdroje")
            .alert("Chyba", isPresented: $showAlert, actions: {
                Button("OK", role: .cancel) {}
            }, message: {
                Text(feedViewModel.errorMessage ?? "Neznámá chyba")
            })
        }
    }

    private func deleteSource(at offsets: IndexSet) {
        for index in offsets {
            let source = feedViewModel.savedSources[index]
            feedViewModel.removeSource(source)
        }
    }
}
