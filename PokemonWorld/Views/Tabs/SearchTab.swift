//
//  Search.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import SwiftUI

struct SearchTab: View {
    @EnvironmentObject var searchPokemonViewModel: SearchPokemonViewModel
    
    @State var searchText: String = ""
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(searchPokemonViewModel.listOfpokemons, id: \.self) { pokemon in
                    NavigationLink(destination: PokemonDetailView(pokemon: pokemon).environmentObject(searchPokemonViewModel), label: {
                        PokemonCard(pokemon: pokemon)
                    })
                        .padding(.horizontal, 20)
                }
                .padding(.bottom, 16)
                
                if searchPokemonViewModel.hasMoreRows {
                        ProgressView()
                            .padding(.bottom, 16)
                            .onAppear {
                                print("START MORE")
                                searchPokemonViewModel.getMorePokemons()
                            }
                    }
            }
        }
        .navigationTitle("Pokedex")
        .searchable(text: $searchText)
        .onAppear {
            if searchPokemonViewModel.listOfpokemons.isEmpty {
                searchPokemonViewModel.getInitData()
            }
        }
    }
}

#Preview {
    SearchTab()
}
