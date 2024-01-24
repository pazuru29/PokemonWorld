//
//  Pokemon.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import Foundation

struct PokemonResponse: Codable {
    let count: Int?
    let next: String?
    let results: [Pokemon]
    
    init(count: Int?, next: String?, results: [Pokemon]) {
        self.count = count
        self.next = next
        self.results = results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decodeIfPresent(Int.self, forKey: .count)
        self.next = try container.decodeIfPresent(String.self, forKey: .next)
        self.results = try container.decode([Pokemon].self, forKey: .results)
    }
}

struct Pokemon: Codable, Hashable {
    let name: String?
    let url: String?
}
