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
        HStack {
            Image("unknownPokemon")
                .resizable()
                .scaledToFit()
            
            Text(pokemon.name?.uppercased() ?? "Unknown")
                .font(.title3)
                .fontWeight(.bold)
            
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
