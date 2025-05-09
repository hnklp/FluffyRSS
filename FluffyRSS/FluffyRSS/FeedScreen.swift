//
//  FeedScreen.swift
//  FluffyRSS
//
//  Created by Hynek Půta on 29/04/2025.
//

import SwiftUI

struct FeedScreen: View {
    @ObservedObject var feedViewModel: FeedViewModel

    @State private var selectedURL: URL? = nil
    @State private var showSafari = true

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d. M. yyyy HH:mm"
        return formatter
    }()

    var body: some View {
        NavigationView {
            List(feedViewModel.feedItems) { item in
                Button {
                    // Zajištění, že se selectedURL nastaví správně pro každý item
                    if let url = URL(string: item.link) {
                        selectedURL = url
                        showSafari = true
                    }
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(item.title)
                                .font(.headline)
                            Spacer()
                            Image(systemName: "arrow.forward.circle")
                                .foregroundColor(.blue)
                        }

                        HStack {
                            Text(item.sourceTitle)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            if let date = item.pubDate {
                                Text(dateFormatter.string(from: date))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.vertical, 12)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Feed")
            
            .refreshable {
                feedViewModel.loadFeed()
            }
            .sheet(isPresented: $showSafari) {
                // Zajištění správného zobrazení SafariView pro aktuální selectedURL
                if let url = selectedURL {
                    SafariView(url: url)
                        .onDisappear {
                            // Reset selectedURL po zavření SafariView
                            selectedURL = nil
                        }
                }
            }
        }
    }
}
