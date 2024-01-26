//
//  Collection.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import SwiftUI

struct BackpackTab: View {
    @EnvironmentObject var backpackViewModel: BackpackViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 10) {
                ForEach(backpackViewModel.listOfPokemons, id: \.self) { pokemon in
                    VStack {
                        if let image = backpackViewModel.mapOfImages[pokemon.id ?? -1] {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                        } else {
                            Image("unknownPokemon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                        }
                        Text(pokemon.name?.uppercased() ?? "")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.appText)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.all, 12)
                    .addBorder(.appPrimary, width: 2, cornerRadius: 16)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
        }
            .navigationTitle("Backpack")
            .onAppear {
                backpackViewModel.getInitData()
            }
    }
}
