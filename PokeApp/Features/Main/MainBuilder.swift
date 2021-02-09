//
//  MainBuilder.swift
//  PokeApp
//
//  Created by Luis Costa on 08/02/2021.
//

import UIKit

final class MainBuilder {
    private var navigator: NavigatorProtocol?
    private var viewModel: MainViewModelProtocol?
    
    func setNavigator(_ navigator: NavigatorProtocol) -> Self {
        self.navigator = navigator
        return self
    }
    
    func setViewModel(_ viewModel: MainViewModelProtocol) -> Self {
        self.viewModel = viewModel
        return self
    }
    
    func build() -> UIViewController {
        guard
            let viewModel = viewModel,
            let navigator = navigator else {
            fatalError("Missing dependecies")
        }
        
        return MainViewController(viewModel: viewModel, navigator: navigator)
    }
}
