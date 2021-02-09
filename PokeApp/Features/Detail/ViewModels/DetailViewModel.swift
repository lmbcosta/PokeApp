//
//  DetailViewModel.swift
//  PokeApp
//
//  Created by Luis Costa on 08/02/2021.
//

import UIKit

protocol DetailViewModelProtocol {
    func numberOfSections() -> Int
    func numberOfItems(for section: Int) -> Int
    func getSectionTitle(section: Int) -> String?
    func getTextFor(item: Int, section: Int) -> String
    func getUrlForImage() -> URL?
}

final class DetailViewModel: DetailViewModelProtocol {
    private let provider: PokemonProviderProtocol
    private var viewModels: [PokemonDetailViewModel] = []
    
    init(provider: PokemonProviderProtocol) {
        self.provider = provider
        self.viewModels = buildViewModels()
    }
    
    func numberOfSections() -> Int {
        viewModels.count + 1
    }
    
    func numberOfItems(for section: Int) -> Int {
        if section == Sections.image {
            return 1
        }
        
        let index = section - 1
        return viewModels[index].items.count
    }
    
    func getSectionTitle(section: Int) -> String? {
        guard section > 0 else { return nil }
        
        let index = section - 1
        return viewModels[index].sectionTitle
    }
    
    func getTextFor(item: Int, section: Int) -> String {
        let index = section - 1
        return viewModels[index].items[item]
    }
    
    func getUrlForImage() -> URL? {
        guard
            let urlString = provider.getCachedModel()?.sprites.frontDefault else {
            return nil
        }
        
        return URL(string: urlString)
    }
    
    // MARK: - Private functions
    
    private func buildViewModels() -> [PokemonDetailViewModel] {
        guard let model = provider.getCachedModel() else {
            return []
        }
        
        return [
            buildMainSection(model: model),
            buildTypesSection(model: model),
            buildAbilitiesSestion(model: model),
            buildMovesSection(model: model)
        ]
    }
    
    private func buildMainSection(model: PokemonModel) -> PokemonDetailViewModel {
        .init(sectionTitle: nil,
              items: [
                String(format: Strings.name, model.name),
                String(format: Strings.height, "\(model.height)"),
                String(format: Strings.weight, "\(model.weight)")
              ])
    }
    
    private func buildTypesSection(model: PokemonModel) -> PokemonDetailViewModel {
        .init(sectionTitle: Strings.types,
              items: model.types.map({ $0.type.name.capitalized }))
    }
    
    private func buildMovesSection(model: PokemonModel) -> PokemonDetailViewModel {
        .init(sectionTitle: Strings.moves,
              items: model.moves.map({ $0.move.name.capitalized }))
    }
    
    private func buildAbilitiesSestion(model: PokemonModel) -> PokemonDetailViewModel {
        .init(sectionTitle: Strings.abilities,
              items: model.abilities.map({ $0.ability.name.capitalized }))
    }
}

private extension DetailViewModel {
    struct Strings {
        static let name = "Name: %@"
        static let height = "Height: %@"
        static let weight = "Weight: %@"
        static let types = "Types:"
        static let abilities = "Abilities:"
        static let moves = "Moves:"
    }
    
    struct Sections {
        static let image = 0
        static let main = 1
        static let types = 2
        static let abilities = 3
        static let moves = 4
        
    }
}
