//
//  Search.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import SwiftUI

struct PokedexTab: View {
    @EnvironmentObject var pokedexViewModel: PokedexViewModel
    
    @State var isLoading: Bool = true
    
    var body: some View {
        Group {
            if isLoading {
                loadingView()
            } else {
                listOfPokemons()
            }
        }
        .navigationTitle("Pokedex")
        .onAppear {
            if pokedexViewModel.listOfpokemons.isEmpty {
                isLoading = !pokedexViewModel.getInitData()
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
                ForEach(pokedexViewModel.listOfpokemons, id: \.self) { pokemon in
                    NavigationLink(destination: PokemonDetailView(pokemon: pokemon), label: {
                        PokemonCard(pokemon: pokemon, image: pokedexViewModel.mapOfImages[pokemon.url ?? ""])
                    })
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 16)
                
                if pokedexViewModel.hasMoreRows {
                    ProgressView()
                        .padding(.bottom, 16)
                        .onAppear {
                            print("START MORE")
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
