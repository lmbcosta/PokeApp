//
//  ProviderTests.swift
//  PokeAppTests
//
//  Created by Luis Costa on 11/02/2021.
//

import XCTest
@testable import PokeApp

class ProviderTests: XCTestCase {
    private let bundle = Bundle(for: ModelTests.self)
    private let jsonFileName = "PokemonResponse"
    private let jsonFileName2 = "PokemonResponse2"
    
    func testProviderEmptyCache() {
        // Given
        let model: PokemonModel = bundle.decodeFile(name: jsonFileName)!
        let service: PokemonServiceProtocol = MockPokemonService(results: [.success(model)])
        let sut: PokemonProviderProtocol = PokemonProvider(service: service)
        
        // When
        let cachedModel = sut.getCachedModel()
        
        
        // Then
        XCTAssertNil(cachedModel)
    }
    
    func testProviderWithCache() {
        // Given
        let equalExpectation = expectation(description: "Objects must have same id")
        let model: PokemonModel = bundle.decodeFile(name: jsonFileName)!
        let service: PokemonServiceProtocol = MockPokemonService(results: [.success(model)])
        let sut: PokemonProviderProtocol = PokemonProvider(service: service)
        
        // When
        sut.fetchPokemon(with: 233, then: { result in
            if case let .success(receivedModel) = result,
               model.id == receivedModel.id {
                equalExpectation.fulfill()
            }
        })
        
        // Then
        wait(for: [equalExpectation], timeout: 3)
    }
    
    func testProviderUpdatecache() {
        // Given
        let differentExpectation = expectation(description: "Objects must have same id")
        let model1: PokemonModel = bundle.decodeFile(name: jsonFileName)!
        let model2: PokemonModel = bundle.decodeFile(name: jsonFileName2)!
        
        let service: PokemonServiceProtocol = MockPokemonService(results: [.success(model1), .success(model2)])
        let sut: PokemonProviderProtocol = PokemonProvider(service: service)
        
        // When
        sut.fetchPokemon(with: 0, then: { _ in
            sut.fetchPokemon(with: 0, then: { result in
                if case let .success(responseModel) = result,
                   responseModel.id != model1.id {
                    differentExpectation.fulfill()
                }
            })
        })
        
        // Then
        wait(for: [differentExpectation], timeout: 60)
    }
}
