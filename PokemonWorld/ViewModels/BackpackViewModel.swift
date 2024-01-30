//
//  BackpackViewModel.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 26.01.2024.
//

import SwiftUI

class BackpackViewModel: ObservableObject {
    @Published var listOfPokemons: [(String, PokemonDetail)] = []
    
    @Published var mapOfImages: [Int:UIImage] = [:]
    
    func getInitData() -> Bool {
        listOfPokemons.removeAll()
        
        let listOfSavedPokemons = CoreDataManager.shared.getSavedPokemons()
        
        for pokemon in listOfSavedPokemons {
            if let pokemonDetail = PokemonDetail.fromJSON(json: pokemon.jsonPokemon ?? "") {
                listOfPokemons.append((pokemon.key ?? "", pokemonDetail))
                mapOfImages[pokemonDetail.id ?? -1] = UIImage(data: pokemon.image ?? Data())
            }
        }
        
        return true
    }
}
