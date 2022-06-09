//
//  View+methods.swift
//  XCANews
//
//  Created by Roman Rybachenko on 05.06.2022.
//

import SwiftUI

extension View {
    func presentShareSheet(with url: URL) {
        let rootVc = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController
        let activityVc = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        rootVc?.present(activityVc, animated: true)
    }
}
