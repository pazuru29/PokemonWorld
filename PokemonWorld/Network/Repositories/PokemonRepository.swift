//
//  NewsRepository.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import Foundation

protocol PokemonRepositoryProtocol {
    func getAllPokemons() async throws -> PokemonResponse
}

class PokemonRepository: PokemonRepositoryProtocol {
    func getAllPokemons() async throws -> PokemonResponse {
        print("Start ALL POKEMONS request")
        
        let response = try await APIRequestDispatcher.request(apiRouter: .allPokemons, responseClass: PokemonResponse.self)
        
        return response
    }
    
    func getMorePokemons(stringUrl: String) async throws -> PokemonResponse {
        print("Start MORE POKEMONS request")
        
        let response = try await APIRequestDispatcher.requestFromString(stringUrl: stringUrl, responseClass: PokemonResponse.self)
        
        return response
    }
    
    func getPokemonDetail(stringUrl: String) async throws -> PokemonDetail {
        print("Start POKEMON DETAIL request")
        
        let response = try await APIRequestDispatcher.requestFromString(stringUrl: stringUrl, responseClass: PokemonDetail.self)
        
        return response
    }
}
