//
//  NewsRepository.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import Foundation

protocol PokemonRepositoryProtocol {
    func getAllPokemons() async throws -> PokemonResponse
    
    func getMorePokemons(stringUrl: String) async throws -> PokemonResponse
    
    func getPokemonDetail(stringUrl: String) async throws -> PokemonDetail
}

class PokemonRepository: PokemonRepositoryProtocol {
    func getAllPokemons() async throws -> PokemonResponse {
        dPrint("Start ALL POKEMONS request")
        
        let response = try await APIRequestDispatcher.request(apiRouter: .allPokemons, responseClass: PokemonResponse.self)
        
        return response
    }
    
    func getMorePokemons(stringUrl: String) async throws -> PokemonResponse {
        dPrint("Start MORE POKEMONS request")
        
        let response = try await APIRequestDispatcher.requestFromString(stringUrl: stringUrl, responseClass: PokemonResponse.self)
        
        return response
    }
    
    func getPokemonDetail(stringUrl: String) async throws -> PokemonDetail {
        dPrint("Start POKEMON DETAIL request")
        
        let response = try await APIRequestDispatcher.requestFromString(stringUrl: stringUrl, responseClass: PokemonDetail.self)
        
        return response
    }
}
