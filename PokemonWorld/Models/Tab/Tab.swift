//
//  Tab.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case pokedex = "list.bullet.rectangle"
    case backpack = "backpack"
    case settings = "gear.circle"
    
    var activeIcon: String {
        switch self {
        case .pokedex:
            "list.bullet.rectangle.fill"
        case .backpack:
            "backpack.fill"
        case .settings:
            "gear.circle.fill"
        }
    }
    
    var title: String {
        switch self {
        case .pokedex:
            "Pokedex"
        case .backpack:
            "Backpack"
        case .settings:
            "Settings"
        }
    }
}
