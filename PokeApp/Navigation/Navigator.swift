//
//  Navigator.swift
//  PokeApp
//
//  Created by Luis Costa on 08/02/2021.
//

import UIKit

final class Navigator: NavigatorProtocol {
    private let provider: PokemonProviderProtocol
    
    init(provider: PokemonProviderProtocol) {
        self.provider = provider
    }
    
    func navigateToDetail(from viewController: UIViewController) {
        let viewModel = DetailViewModel(provider: provider)
        let controller = DetailBuilder().setViewModel(viewModel).build()
        viewController.navigationController?.pushViewController(controller, animated: true)
    }
}
