//
//  MockMainViewModel.swift
//  PokeAppTests
//
//  Created by Luis Costa on 11/02/2021.
//

import Foundation
@testable import PokeApp

final class MockMainViewModel: MainViewModelProtocol {
    private(set) var result: Result<PokemonMainViewModel, Error>
    var numberOfCalls = 0
    
    init(result: Result<PokemonMainViewModel, Error>) {
        self.result = result
    }
    
    func fetchMainData(then handler: @escaping (Result<PokemonMainViewModel, Error>) -> Void) {
        numberOfCalls += 1
        handler(result)
    }
}
