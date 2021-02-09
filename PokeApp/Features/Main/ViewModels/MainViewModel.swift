//
//  MainViewModel.swift
//  PokeApp
//
//  Created by Luis Costa on 08/02/2021.
//

import Foundation

protocol MainViewModelProtocol {
    func fetchMainData(then handler: @escaping (Result<PokemonMainViewModel, Error>) -> Void)
}

final class MainViewModel: MainViewModelProtocol {
    private let provider: PokemonProviderProtocol
    
    private var model: PokemonModel?
    
    init(provider: PokemonProviderProtocol) {
        self.provider = provider
    }
    
    // MARK: - MainViewModelProtocol
    
    func fetchMainData(then handler: @escaping (Result<PokemonMainViewModel, Error>) -> Void) {
        let randomID = Int.random(in: 1...Constants.pokemonIDLimit)
        fetchData(with: randomID, then: handler)
    }
    
    // MARK: - Private functions
    
    private func fetchData(with id: Int, then handler: @escaping (Result<PokemonMainViewModel, Error>) -> Void) {
        provider.fetchPokemon(with: id, then: { [weak self] result in
            switch result {
            case let .success(model):
                guard let viewModel = PokemonMainViewModel(from: model) else {
                    return handler(.failure(PokemonError.parsing))
                }
                self?.model = model
                return handler(.success(viewModel))
                
            case let .failure(error):
                return handler(.failure(error))
            }
        })
    }
}

// MARK: - Constants

private extension MainViewModel {
    struct Constants {
        static let pokemonIDLimit: Int = 300
    }
}

// MARK: - Helper

private extension PokemonMainViewModel {
    init?(from model: PokemonModel) {
        guard let url = URL(string: model.sprites.frontDefault) else {
            return nil
        }
        
        self.init(name: model.name, imgURL: url)
    }
}

