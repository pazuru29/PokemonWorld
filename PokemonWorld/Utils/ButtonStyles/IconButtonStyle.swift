//
//  IconButtonStyle.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import SwiftUI

struct IconButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .fontWeight(.bold)
            .frame(width: 48, height: 48)
            .background(.clear)
            .foregroundStyle(getForeground(isPressed: configuration.isPressed))
            .animation(.easeIn, value: isEnabled)
    }
    
    func getForeground(isPressed: Bool) -> Color {
        guard isEnabled else {
            return .appTextSecondary
        }
        return isPressed ? .appPrimaryTapped : .appPrimary
    }
}

#Preview {
    Button(action: {
        
    }, label: {
        Image(systemName: "rectangle.and.pencil.and.ellipsis")
    })
    .buttonStyle(IconButtonStyle())
}
