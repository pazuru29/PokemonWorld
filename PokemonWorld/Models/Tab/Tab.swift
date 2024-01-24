//
//  Tab.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case search = "magnifyingglass"
    case comparison = "arrowshape.left.arrowshape.right"
    case collection = "shippingbox"
    case settings = "gear.circle"
    
    var activeIcon: String {
        switch self {
        case .search:
            "sparkle.magnifyingglass"
        case .comparison:
            "arrowshape.left.arrowshape.right.fill"
        case .collection:
            "shippingbox.fill"
        case .settings:
            "gear.circle.fill"
        }
    }
    
    var title: String {
        switch self {
        case .search:
            "Search"
        case .comparison:
            "Comparison"
        case .collection:
            "Collection"
        case .settings:
            "Settings"
        }
    }
}
