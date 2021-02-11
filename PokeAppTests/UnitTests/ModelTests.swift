//
//  ModelTests.swift
//  PokeAppTests
//
//  Created by Luis Costa on 11/02/2021.
//

import XCTest
@testable import PokeApp

class ModelTests: XCTestCase {
    private let bundle = Bundle(for: ModelTests.self)
    private let jsonFileName = "PokemonResponse"
    
    func testPokemonResponse() {
        // When
        let sut: PokemonModel = bundle.decodeFile(name: jsonFileName)!
        
        // Then
        XCTAssertNotNil(sut)
    }
    
    func testURLStringPokmenonAvatar() {
        // Given
        let sut: PokemonModel = bundle.decodeFile(name: jsonFileName)!
        
        // When
        let defaultAvatarURL = sut.sprites.frontDefault
        
        // Then
        XCTAssertTrue(defaultAvatarURL == "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/233.png")
    }
    
    func testURLPokemonAvatar() {
        // Given
        let sut: PokemonModel = bundle.decodeFile(name: jsonFileName)!
        
        // When
        let defaultAvatarURLString = sut.sprites.frontDefault
        
        // Then
        XCTAssertNotNil(URL(string: defaultAvatarURLString))
    }
    
    func testPokemonEmptyAbilities() {
        // Given
        let sut: PokemonModel = bundle.decodeFile(name: jsonFileName)!
        
        // When
        let abilitiesCount = sut.abilities.count
        
        // Then
        XCTAssertTrue(abilitiesCount > 0)
    }
    
    func testPokemonAbility() {
        // Given
        let sut: PokemonModel = bundle.decodeFile(name: jsonFileName)!
        
        // When
        let abilityName = sut.abilities.first?.ability.name
        
        // Then
        XCTAssertNotNil(abilityName)
        XCTAssertTrue(abilityName == "trace")
    }
    
    func testPokemonMoves() {
        // Given
        let sut: PokemonModel = bundle.decodeFile(name: jsonFileName)!
        
        // When
        let moves = sut.moves
        
        // Then
        XCTAssertTrue(moves.count == 68)
    }
    
    func testPokemonHeight() {
        // Given
        let sut: PokemonModel = bundle.decodeFile(name: jsonFileName)!
        
        // When
        let pokemonHeight = sut.height
        
        // Then
        XCTAssertNotNil(pokemonHeight)
    }
    
    func testPokemonWeight() {
        // Given
        let sut: PokemonModel = bundle.decodeFile(name: jsonFileName)!
        
        // When
        let pokemonWeight = sut.weight
        
        // Then
        XCTAssertNotNil(pokemonWeight)
    }
}



