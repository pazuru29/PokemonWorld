//
//  BackpackViewModel.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 26.01.2024.
//

import SwiftUI

class BackpackViewModel: ObservableObject {
    @Published var listOfPokemons = [(String, PokemonDetail)]()
    
    @Published var state: LoaderState = .loading
    
    func getInitData() {
        state = .loading
        
        listOfPokemons.removeAll()
        
        let listOfSavedPokemons = CoreDataManager.shared.getSavedPokemons()
        
        for pokemon in listOfSavedPokemons {
            if let pokemonDetail = PokemonDetail.fromJSON(json: pokemon.jsonPokemon ?? "") {
                listOfPokemons.append((pokemon.key ?? "", pokemonDetail))
                let image = UIImage(data: pokemon.image ?? Data()) ?? UIImage(systemName: "unknownPokemon") ?? UIImage()
                ImageCache.shared.set(image, forKey: pokemon.key ?? "")
            }
        }
        
        state = .loaded
    }
}
