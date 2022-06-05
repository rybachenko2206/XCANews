//
//  SafariView.swift
//  XCANews
//
//  Created by Roman Rybachenko on 05.06.2022.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = SFSafariViewController(url: url)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
