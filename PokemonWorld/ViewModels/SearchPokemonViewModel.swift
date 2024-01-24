//
//  SearchPokemonViewModel.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import Foundation

class SearchPokemonViewModel: ObservableObject {
    private let pokemonRepository: PokemonRepository = PokemonRepository()
    
    @MainActor @Published var listOfpokemons: [Pokemon] = []
    
    @Published var hasMoreRows: Bool = false
    
    @Published var currentPokemonDetail: PokemonDetail?
    
    private var nextStringUrl: String?
    
    //MARK: Get first 20 pokemons
    func getInitData() {
        Task {
            do {
                //Get response all pokemon
                let pokemonResponse = try await pokemonRepository.getAllPokemons()
                //Set next url
                nextStringUrl = pokemonResponse.next
                //Set to list
                await MainActor.run {
                    listOfpokemons = pokemonResponse.results
                    hasMoreRows = nextStringUrl != nil
                }
            } catch {
                print("Fetching establishments failed with error \(error)")
            }
        }
    }
    
    //MARK: get more pokemons
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
                    listOfpokemons.append(contentsOf: pokemonResponse.results)
                    hasMoreRows = nextStringUrl != nil
                }
            } catch {
                print("Fetching establishments failed with error \(error)")
            }
        }
    }
    
    //MARK: find detail by pokemon
    func getDetailByPokemon(stringUrl: String?) {
        guard let url = stringUrl else {
            return
        }
        
        Task {
            do {
                //Get response more pokemon
                let pokemonDetail = try await pokemonRepository.getPokemonDetail(stringUrl: url)
                //Set pokemon detail
                await MainActor.run {
                    currentPokemonDetail = pokemonDetail
                }
            } catch {
                print("Fetching establishments failed with error \(error)")
            }
        }
    }
}
