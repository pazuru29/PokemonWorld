//
//  PokemonDetailView.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import SwiftUI

struct PokemonDetailView: View {
    @EnvironmentObject var searchPokemonViewModel: SearchPokemonViewModel
    
    let pokemon: Pokemon
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                image()
                
                typeView()
                    .padding(.top, 36)
                
                Spacer()
            }
        }
            .navigationTitle(pokemon.name?.uppercased() ?? "Unknown")
            .onAppear {
                //Find detail by pokemon
                searchPokemonViewModel.getDetailByPokemon(stringUrl: pokemon.url)
            }
            .onDisappear {
                searchPokemonViewModel.currentPokemonDetail = nil
            }
    }
    
    @ViewBuilder
    func image() -> some View {
        if let url = searchPokemonViewModel.currentPokemonDetail?.imageUrl {
            AsyncImage(url: URL(string: url)) { image in
                image
                    .image?.resizable()
                    .scaledToFit()
                    .frame(height: 250)
            }
        } else {
            Image("unknownPokemon")
                .resizable()
                .scaledToFit()
                .frame(height: 250)
        }
    }
    
    @ViewBuilder
    func typeView() -> some View {
        HStack(spacing: 16) {
            ForEach(searchPokemonViewModel.currentPokemonDetail?.types ?? [], id: \.self) { type in
                VStack {
                    Image(type.type?.name ?? "")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    
                    Text(type.type?.name?.uppercased() ?? "")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
        }
    }
}
