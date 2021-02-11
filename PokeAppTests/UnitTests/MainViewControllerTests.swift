//
//  MainViewControllerTests.swift
//  PokeAppTests
//
//  Created by Luis Costa on 11/02/2021.
//

import XCTest
@testable import PokeApp

class MainViewControllerTests: XCTestCase {
    func testDetailNavigation() {
        // Given
        let pokemonViewModel = PokemonMainViewModel(name: "Test", imgURL: URL(string: "TEST")!)
        let mockViewModel = MockMainViewModel(result: .success(pokemonViewModel))
        let mockNavigator = MockNavigator()
        let sut = MainViewController(viewModel: mockViewModel, navigator: mockNavigator)
        
        // When
        sut.navigateToDetail()
        
        // Then
        XCTAssertTrue(mockNavigator.isOnDetail)
    }
    
    func testTapNewPokemon() {
        // Given
        let pokemonViewModel = PokemonMainViewModel(name: "Test", imgURL: URL(string: "TEST")!)
        let mockViewModel = MockMainViewModel(result: .success(pokemonViewModel))
        let mockNavigator = MockNavigator()
        let sut = MainViewController(viewModel: mockViewModel, navigator: mockNavigator)
        
        // When
        sut.didTapNewPokemon()
        
        // Then
        XCTAssertTrue(mockViewModel.numberOfCalls == 1)
    }
}

extension MainViewControllerTests {
    func buildSUT(navigator: NavigatorProtocol) -> MainViewController {
        let pokemonViewModel = PokemonMainViewModel(name: "Test", imgURL: URL(string: "TEST")!)
        let viewModel = MockMainViewModel(result: .success(pokemonViewModel))
        return .init(viewModel: viewModel, navigator: navigator)
    }
}
