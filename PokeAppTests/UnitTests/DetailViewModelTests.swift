//
//  DetailViewModelTests.swift
//  PokeAppTests
//
//  Created by Luis Costa on 11/02/2021.
//

import XCTest
@testable import PokeApp

class DetailViewModelTests: XCTestCase {
    private let bundle = Bundle(for: ModelTests.self)
    private let jsonFileName2 = "PokemonResponse2"
    private let jsonFileEmpty = "PokemonResponseEmpty"
    
    func testAvatarURL() {
        // Given
        let model: PokemonModel = bundle.decodeFile(name: jsonFileName2)!
        let service: PokemonServiceProtocol = MockPokemonService(results: [.success(model)])
        let provider: PokemonProviderProtocol = PokemonProvider(service: service)
        let equalExpectation = expectation(description: "URL are equals")
        let sut = DetailViewModel(provider: provider)
        
        // When
        provider.fetchPokemon(with: 1, then: { _ in
            let avatarUrl = sut.getUrlForImage()
            if avatarUrl?.absoluteString == "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png" {
                equalExpectation.fulfill()
            }
        })
        
        // Then
        wait(for: [equalExpectation], timeout: 2)
    }
    
    func testDetailNumberOfSections() {
        // Given
        let model: PokemonModel = bundle.decodeFile(name: jsonFileName2)!
        let service: PokemonServiceProtocol = MockPokemonService(results: [.success(model)])
        let provider: PokemonProviderProtocol = PokemonProvider(service: service)
        let sut = DetailViewModel(provider: provider)
        
        // When
        provider.fetchPokemon(with: 1, then: { _ in
            XCTAssert(sut.getSectionTitle(section: 0) == nil)
            XCTAssert(sut.numberOfSections() == 1)
        })
    }
}
