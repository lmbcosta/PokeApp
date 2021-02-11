//
//  MockPokemonService.swift
//  PokeAppTests
//
//  Created by Luis Costa on 11/02/2021.
//

@testable import PokeApp
import Foundation

final class MockPokemonService: PokemonServiceProtocol {
    private var results: [Result<PokemonModel, Error>]
    
    init(results: [Result<PokemonModel, Error>]) {
        self.results = results
    }
    
    func fetchPokemon(with id: Int, then handler: @escaping (Result<PokemonModel, Error>) -> Void) {
        if let first = results.first {
            results.removeFirst()
            handler(first)
        }
    }
}
