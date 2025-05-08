//
//  SafariView.swift
//  FluffyRSS
//
//  Created by Hynek Půta on 01/05/2025.
//


import SwiftUI
import SafariServices

struct SafariView: View {
    let url: URL
    
    var body: some View {
        SafariViewController(url: url)
            .edgesIgnoringSafeArea(.all)
    }
}

struct SafariViewController: UIViewControllerRepresentable {
    var url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}

