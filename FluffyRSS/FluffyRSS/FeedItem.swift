//
//  FeedItem.swift
//  FluffyRSS
//
//  Created by Hynek Půta on 29/04/2025.
//

import Foundation

struct FeedItem: Identifiable {
    let id: UUID
    let title: String
    let link: String
    let pubDate: Date?
    let sourceTitle: String
}
