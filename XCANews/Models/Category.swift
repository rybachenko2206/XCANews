//
//  Category.swift
//  XCANews
//
//  Created by Roman Rybachenko on 05.06.2022.
//

import Foundation

enum Category: String, CaseIterable, Identifiable {
    case general
    case business
    case technology
    case entertainment
    case science
    case sports
    case health
    
    var title: String {
        switch self {
        case .general: return "Top headlines"
        default: return self.rawValue.capitalized
        }
    }
    
    var id: Self { self }
}
