//
//  MainButtonStyle.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import SwiftUI

struct MainButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(getBackground(isPressed: configuration.isPressed))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5, y: 5)
            .animation(.easeIn, value: isEnabled)
    }
    
    func getBackground(isPressed: Bool) -> Color {
        guard isEnabled else {
            return .appTextSecondary
        }
        return isPressed ? .appPrimary : .appPrimaryTapped
    }
}

#Preview {
    Button("ddd") {
        
    }
    .buttonStyle(MainButtonStyle())
}
