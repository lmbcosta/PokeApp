//
//  PokemonService.swift
//  PokeApp
//
//  Created by Luis Costa on 08/02/2021.
//

import Foundation

protocol PokemonServiceProtocol {
    func fetchPokemon(with id: Int, then handler: @escaping (Result<PokemonModel, Error>) -> Void)
}

final class PokemonService: PokemonServiceProtocol {
    func fetchPokemon(with id: Int, then handler: @escaping (Result<PokemonModel, Error>) -> Void) {
        guard let url = buildURL(for: id) else {
            return handler(.failure(PokemonError.invalidURL))
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            if let error = error {
                return handler(.failure(error))
            }
            
            guard let data = data else {
                return handler(.failure(PokemonError.noData))
            }
            
            do {
                let response = try JSONDecoder().decode(PokemonModel.self, from: data)
                return handler(.success(response))
            } catch let error {
                return handler(.failure(error))
            }
        })
        .resume()
    }
    
    private func buildURL(for id: Int) -> URL? {
        return buildURLComponents(for: id).url
    }
    
    private func buildURLComponents(for id: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = String(format: Constants.path, "\(id)")
        return components
    }
}

extension PokemonService {
    struct Constants {
        static let host = "pokeapi.co"
        static let path = "/api/v2/pokemon/%@/"
        static let get = "GET"
        static let scheme = "https"
    }
}
