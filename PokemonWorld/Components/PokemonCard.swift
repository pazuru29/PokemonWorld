//
//  PokemonCard.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import SwiftUI

struct PokemonCard: View {
    let pokemon: Pokemon
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack(alignment: .trailing) {
                Image("unknownPokemon")
                    .resizable()
                    .scaledToFit()
                
                Color.white
                    .blur(radius: 3)
                    .frame(width: 10)
                    .offset(x: 5)
            }
            .frame(width: 100)
            
            Text(pokemon.name?.uppercased() ?? "Unknown")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.appText)
                .padding(.horizontal, 16)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .addBorder(.appPrimary, width: 2, cornerRadius: 25)
    }
}

#Preview {
    PokemonCard(pokemon: Pokemon(name: "Name", url: ""))
}
