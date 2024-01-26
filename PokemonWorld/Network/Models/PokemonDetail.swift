//
//  PokemonDetail.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import Foundation

struct PokemonDetail: Codable, Hashable {
    let id: Int?
    let name: String?
    let baseExperience: Int?
    let height: Int?
    let weight: Int?
    let sprites: Sprites?
    let species: Species?
    let stats: [Stats]?
    let types: [Types]?
    
    var imageUrl: String? {
        sprites?.other?.home?.frontDefault ?? sprites?.other?.dreamWorld?.frontDefault ?? sprites?.frontDefault
    }
    
    init(id: Int?, name: String?, baseExperience: Int?, height: Int?, weight: Int?, sprites: Sprites?, species: Species?, stats: [Stats]?, types: [Types]?) {
        self.id = id
        self.name = name
        self.baseExperience = baseExperience
        self.height = height
        self.weight = weight
        self.sprites = sprites
        self.species = species
        self.stats = stats
        self.types = types
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.height = try container.decodeIfPresent(Int.self, forKey: .height)
        self.weight = try container.decodeIfPresent(Int.self, forKey: .weight)
        self.sprites = try container.decodeIfPresent(Sprites.self, forKey: .sprites)
        self.species = try container.decodeIfPresent(Species.self, forKey: .species)
        self.stats = try container.decodeIfPresent([Stats].self, forKey: .stats)
        self.types = try container.decodeIfPresent([Types].self, forKey: .types)
        self.baseExperience = try container.decodeIfPresent(Int.self, forKey: .baseExperience)
    }
    
    private enum CodingKeys: String, CodingKey {
            case id, name, height, weight, sprites, species, stats, types
            case baseExperience = "base_experience"
        }
}

//MARK: sprites
struct Sprites: Codable, Hashable {
    let frontDefault: String?
    let other: OtherSprites?
    
    private enum CodingKeys: String, CodingKey {
            case other
            case frontDefault = "front_default"
        }
}

struct OtherSprites: Codable, Hashable {
    let dreamWorld: DreamWorld?
    let home: HomeSprites?
    
    init(dreamWorld: DreamWorld?, home: HomeSprites?) {
        self.dreamWorld = dreamWorld
        self.home = home
    }
    
    private enum CodingKeys: String, CodingKey {
            case home
            case dreamWorld = "dream_world"
        }
}

struct HomeSprites: Codable, Hashable {
    let frontDefault: String?
    
    init(frontDefault: String?) {
        self.frontDefault = frontDefault
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.frontDefault = try container.decodeIfPresent(String.self, forKey: .frontDefault)
    }
    
    private enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
}

struct DreamWorld: Codable, Hashable {
    let frontDefault: String?
    
    init(frontDefault: String?) {
        self.frontDefault = frontDefault
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.frontDefault = try container.decodeIfPresent(String.self, forKey: .frontDefault)
    }
    
    private enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
}

//MARK: Species
struct Species: Codable, Hashable {
    let name: String?
    let url: String?
    
    init(name: String?, url: String?) {
        self.name = name
        self.url = url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
    }
}

//MARK: Stats
struct Stats: Codable, Hashable {
    let base_stat: Int?
    let effort: Int?
    let stat: Stat?
    
    init(base_stat: Int?, effort: Int?, stat: Stat?) {
        self.base_stat = base_stat
        self.effort = effort
        self.stat = stat
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.base_stat = try container.decodeIfPresent(Int.self, forKey: .base_stat)
        self.effort = try container.decodeIfPresent(Int.self, forKey: .effort)
        self.stat = try container.decodeIfPresent(Stat.self, forKey: .stat)
    }
}

struct Stat: Codable, Hashable {
    let name: String?
    let url: String?
    
    init(name: String?, url: String?) {
        self.name = name
        self.url = url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
    }
}

//MARK: Types
struct Types: Codable, Hashable {
    let slot: Int?
    let type: TypeModel?
    
    init(slot: Int?, type: TypeModel?) {
        self.slot = slot
        self.type = type
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.slot = try container.decodeIfPresent(Int.self, forKey: .slot)
        self.type = try container.decodeIfPresent(TypeModel.self, forKey: .type)
    }
}

struct TypeModel: Codable, Hashable {
    let name: String?
    let url: String?
    
    init(name: String?, url: String?) {
        self.name = name
        self.url = url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
    }
}
