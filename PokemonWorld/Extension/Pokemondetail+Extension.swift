//
//  Pokemondetail+Extension.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 26.01.2024.
//

import Foundation

extension PokemonDetail {
    func toJSON() -> String {
        do {
            let jsonEncoder = JSONEncoder()
            
            let jsonData = try jsonEncoder.encode(self)
            
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            
            return json ?? ""
        } catch {
            return ""
        }
    }
    
    static func fromJSON(json: String) -> PokemonDetail? {
        do {
            let jsonDecoder = JSONDecoder()
            
            let jsonData = json.data(using: .utf8) ?? Data()
            
            let decodePokemon = try jsonDecoder.decode(PokemonDetail.self, from: jsonData)
            
            return decodePokemon
        } catch {
            return nil
        }
    }
}
