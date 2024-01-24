//
//  PokemonWorldApp.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 23.01.2024.
//

import SwiftUI

@main
struct PokemonWorldApp: App {
    @AppConfiguration(\.isFirstTime) var isFirstTime
    
    var body: some Scene {
        WindowGroup {
            if isFirstTime {
                NavigationStack{
                    OnboardingCharacterGender()
                }
                .preferredColorScheme(.light)
            } else {
                MainView()
                .preferredColorScheme(.light)
            }
        }
    }
}
