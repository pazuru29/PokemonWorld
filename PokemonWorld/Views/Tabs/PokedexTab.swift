//
//  Search.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import SwiftUI

struct PokedexTab: View {
    @EnvironmentObject var pokedexViewModel: PokedexViewModel
    
    var body: some View {
        Group {
            if pokedexViewModel.state == .loading {
                loadingView()
            } else {
                listOfPokemons()
            }
        }
        .navigationTitle("Pokedex")
        .task {
            if pokedexViewModel.listOfpokemons.isEmpty {
                pokedexViewModel.getInitData()
            } else {
                pokedexViewModel.getImagesFromDB(listOfPokemons: pokedexViewModel.listOfpokemons)
            }
        }
    }
    
    @ViewBuilder
    func loadingView() -> some View {
        VStack {
            ProgressView()
        }
    }
    
    @ViewBuilder
    func listOfPokemons() -> some View {
        ScrollView {
            LazyVStack {
                ForEach(pokedexViewModel.listOfpokemons, id: \.name) { pokemon in
                    NavigationLink(destination: PokemonDetailView(pokemon: pokemon), label: {
                        PokemonCard(pokemon: pokemon, image: ImageCache.shared.get(forKey: pokemon.url ?? ""))
                    })
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 16)
                
                if pokedexViewModel.hasMoreRows {
                    ProgressView()
                        .padding(.bottom, 16)
                        .onAppear {
                            dPrint("START MORE")
                            pokedexViewModel.getMorePokemons()
                        }
                }
            }
        }
    }
}

#Preview {
    PokedexTab()
}
