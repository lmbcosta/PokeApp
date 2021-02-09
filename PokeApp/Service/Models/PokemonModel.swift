//
//  PokemonModel.swift
//  PokeApp
//
//  Created by Luis Costa on 08/02/2021.
//

import Foundation

struct PokemonModel: Decodable {
    let id: Int
    let name: String
    let abilities: [PokemonAbilityModel]
    let sprites: SpritesModel
    let height: Double
    let weight: Double
    let types: [PokemonTypeModel]
    let moves: [PokemonMoveModel]
}

struct PokemonAbilityModel: Decodable {
    let ability: AbilityModel
    let isHidden: Bool
    let slot: Int
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct AbilityModel: Decodable {
    let name: String
}

struct SpritesModel: Decodable {
    let frontDefault: String
    let frontShiny: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}

struct StatusModel: Decodable {
    let stat: StatModel
    let base: Int
    
    enum CodingKeys: String, CodingKey {
        case stat
        case base = "base_stat"
    }
}

struct StatModel: Decodable {
    let name: String
}

struct PokemonTypeModel: Decodable {
    let slot: Int
    let type: TypeModel
}

struct TypeModel: Decodable {
    let name: String
}

struct PokemonMoveModel: Decodable {
    let move: MoveModel
}

struct MoveModel: Decodable {
    let name: String
    let url :String
}

enum PokemonError: Error {
    case invalidURL
    case noData
    case parsing
}
