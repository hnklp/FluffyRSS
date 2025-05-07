//
//  FeedViewModel.swift
//  FluffyRSS
//
//  Created by Hynek Půta on 29/04/2025.
//

import Foundation
import Combine
import SwiftUI

class FeedViewModel: ObservableObject {
    @Published var feedItems: [FeedItem] = []
    @Published var errorMessage: String?

    @AppStorage("savedSources") var savedSourcesString: String = ""

    var savedSources: [String] {
        savedSourcesString
            .split(separator: "|")
            .map { String($0) }
            .filter { !$0.isEmpty }
    }

    func addSource(_ newSource: String) {
        var current = savedSources
        guard !current.contains(newSource) else { return }
        guard let _ = URL(string: newSource) else {
            errorMessage = "Neplatná URL adresa."
            return
        }
        current.append(newSource)
        savedSourcesString = current.joined(separator: "|")
        loadFeed()
    }

    func removeSource(_ source: String) {
        let updated = savedSources.filter { $0 != source }
        savedSourcesString = updated.joined(separator: "|")
        loadFeed()
    }

    func loadFeed() {
        feedItems.removeAll()
        errorMessage = nil

        guard !savedSources.isEmpty else {
            errorMessage = "Žádné RSS zdroje k načtení."
            return
        }

        for source in savedSources {
            guard let url = URL(string: source) else {
                errorMessage = "Neplatná URL: \(source)"
                continue
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let parser = RSSParser(data: data) {
                        let newItems = parser.itemsResult
                        DispatchQueue.main.async {
                            self.feedItems.append(contentsOf: newItems)
                            // Seřadíme položky podle data
                            self.feedItems.sort {
                                ($0.pubDate ?? Date.distantPast) > ($1.pubDate ?? Date.distantPast)
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.errorMessage = "Zdroj \(source) nelze načíst jako RSS."
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.errorMessage = "Chyba při načítání: \(error?.localizedDescription ?? "neznámá chyba")"
                    }
                }
            }.resume()
        }
    }
}
