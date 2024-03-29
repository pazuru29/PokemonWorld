//
//  SearchPokemonViewModel.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import SwiftUI

class PokedexViewModel: ObservableObject {
    private let pokemonRepository: PokemonRepository = PokemonRepository()
    
    @MainActor @Published var listOfpokemons: [Pokemon] = []
    
    @Published var hasMoreRows: Bool = false
    
    @Published var state: LoaderState = .loading
    
    private var nextStringUrl: String?
    
    //MARK: Get first 20 pokemons
    func getInitData() {
        state = .loading
        Task {
            do {
                //Get response all pokemon
                let pokemonResponse = try await pokemonRepository.getAllPokemons()
                //Set next url
                nextStringUrl = pokemonResponse.next
                //Set to list
                await MainActor.run {
                    //Get images
                    getImagesFromDB(listOfPokemons: pokemonResponse.results)
                    
                    listOfpokemons = pokemonResponse.results
                    hasMoreRows = nextStringUrl != nil
                    
                    state = .loaded
                }
            } catch {
                dPrint("Fetching establishments failed with error \(error)")
                state = .erorr
            }
        }
    }
    
    //MARK: Get more pokemons
    func getMorePokemons() {
        guard let url = nextStringUrl else {
            return
        }
        Task {
            do {
                //Get response more pokemon
                let pokemonResponse = try await pokemonRepository.getMorePokemons(stringUrl: url)
                //Set next url
                nextStringUrl = pokemonResponse.next
                //Add to list
                await MainActor.run {
                    //Get images
                    getImagesFromDB(listOfPokemons: pokemonResponse.results)
                    
                    listOfpokemons.append(contentsOf: pokemonResponse.results)
                    hasMoreRows = nextStringUrl != nil
                }
            } catch {
                dPrint("Fetching establishments failed with error \(error)")
            }
        }
    }
    
    func getImagesFromDB(listOfPokemons: [Pokemon]) {
        state = .loading
        //GET Saved pokemons
        let listOfSavedPokemons = CoreDataManager.shared.getSavedPokemons()
        
        for pokemon in listOfPokemons {
            guard let url = pokemon.url else { continue }
            
            let savedPokemon = listOfSavedPokemons.first { value in
                value.key == url
            }
            
            if let savedPokemon = savedPokemon {
                let image = UIImage(data: savedPokemon.image ?? Data()) ?? UIImage(systemName: "unknownPokemon") ?? UIImage()
                ImageCache.shared.set(image, forKey: url)
            }
        }
        state = .loaded
    }
}
