//
//  ServiceTests.swift
//  PokeAppTests
//
//  Created by Luis Costa on 11/02/2021.
//

import XCTest
@testable import PokeApp

class ServiceTests: XCTestCase {
    func testIncorrectPokemonID() {
        // Given
        let failureExpectation = expectation(description: "Service should respond with error")
        let sut: PokemonServiceProtocol = PokemonService()
        
        // When
        sut.fetchPokemon(with: -1, then: { result in
            if case .failure = result {
                failureExpectation.fulfill()
            }
        })
        
        // Then
        wait(for: [failureExpectation], timeout: 3)
    }
}

