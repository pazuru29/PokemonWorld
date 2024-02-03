//
//  APIRouter.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import Foundation

enum APIRouter {
    case allPokemons
    
    var host: String {
        switch self {
        case .allPokemons:
            return "pokeapi.co"
        }
    }
    
    var scheme: String {
        switch self {
        case .allPokemons:
            return "https"
        }
    }
    
    var path: String {
        switch self {
        case .allPokemons:
            return "/api/v2/pokemon"
        }
    }
    
    var method: String {
        switch self {
        case .allPokemons:
            return "GET"
        }
    }
    
    var parameters: [URLQueryItem] {
        let queryList: [URLQueryItem] = []
        //queryList.append(URLQueryItem(name: "apiKey", value: "\(APIRouter.apiKey)"))
        
        switch self {
        case .allPokemons:
            break
        }
        
        return queryList
    }
}
