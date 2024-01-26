//
//  BackpackViewModel.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 26.01.2024.
//

import SwiftUI

class BackpackViewModel: ObservableObject {
    @Published var listOfPokemons: [PokemonDetail] = []
    
    @Published var mapOfImages: [Int:UIImage] = [:]
    
    func getInitData() {
        listOfPokemons.removeAll()
        
        let listOfSavedPokemons = CoreDataManager.shared.getSavedPokemons()
        
        for pokemon in listOfSavedPokemons {
            if let pokemonDetail = PokemonDetail.fromJSON(json: pokemon.jsonPokemon ?? "") {
                listOfPokemons.append(pokemonDetail)
                mapOfImages[pokemonDetail.id ?? -1] = UIImage(data: pokemon.image ?? Data())
            }
        }
    }
}
