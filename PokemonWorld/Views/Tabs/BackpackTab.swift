//
//  Collection.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import SwiftUI
import Combine

struct BackpackTab: View {
    @EnvironmentObject var backpackViewModel: BackpackViewModel
    //MARK: Search
    @State var searchText: String = ""
    
    let searchPublisher = PassthroughSubject<String, Never>()
    
    @State var filteredPokemonList: [(String, PokemonDetail)] = []
    
    var body: some View {
        Group{
            if backpackViewModel.state == .loading {
                loadingView()
            } else {
                listOfPokemons()
            }
        }
        .navigationTitle("Backpack")
        .onAppear {
            backpackViewModel.getInitData()
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
        if backpackViewModel.listOfPokemons.isEmpty {
            VStack {
                Text("Oh...\nYou don't have any pokémon yet. \nHurry up and find the first one!")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.appTextSecondary)
            }
        } else {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(filteredPokemonList, id: \.0) { (url, pokemon) in
                        NavigationLink(destination: {
                            PokemonDetailView(pokemon: Pokemon(name: pokemon.name, url: url))
                        }, label: {
                            VStack {
                                if let image = ImageCache.shared.get(forKey: url) {
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
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
            .task {
                if searchText.isEmpty {
                    filteredPokemonList = backpackViewModel.listOfPokemons
                }
            }
            .onChange(of: searchText, { oldValue, newValue in
                if newValue.isEmpty {
                    filteredPokemonList = backpackViewModel.listOfPokemons
                } else {
                    filteredPokemonList = backpackViewModel.listOfPokemons.filter { (id, pokemon) in
                        return pokemon.name?.lowercased().contains(searchText.lowercased()) ?? false
                    }
                }
            })
            .searchable(text: $searchText)
        }
    }
}
