//
//  AppCoordinator.swift
//  PokeApp
//
//  Created by Luis Costa on 08/02/2021.
//

import Foundation

import UIKit

final class AppCoordinator {
    static let shared: AppCoordinator = AppCoordinator()
    
    private init() {}
    
    func buildMainViewController() -> UIViewController {
        let service = PokemonService()
        let provider = PokemonProvider(service: service)
        let navigator = Navigator(provider: provider)
        let viewModel = MainViewModel(provider: provider)
        let mainViewController = MainBuilder()
            .setNavigator(navigator)
            .setViewModel(viewModel)
            .build()
        return mainViewController
    }
}
