//
//  PokemonProvider.swift
//  PokeApp
//
//  Created by Luis Costa on 08/02/2021.
//

import Foundation

protocol PokemonProviderProtocol {
    func getCachedModel() -> PokemonModel?
    func fetchPokemon(with id: Int, then handler: @escaping (Result<PokemonModel, Error>) -> Void)
}

final class PokemonProvider: PokemonProviderProtocol {
    private let service: PokemonServiceProtocol
    private var model: PokemonModel?
    
    init(service: PokemonServiceProtocol) {
        self.service = service
    }
    
    func getCachedModel() -> PokemonModel? {
        return model
    }
    
    func fetchPokemon(with id: Int, then handler: @escaping (Result<PokemonModel, Error>) -> Void) {
        self.service.fetchPokemon(with: id, then: { [weak self] result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                if case let .success(model) = result {
                    self?.model = model
                }
                else {
                    self?.model = nil
                }
                handler(result)
            })
        })
    }
}

