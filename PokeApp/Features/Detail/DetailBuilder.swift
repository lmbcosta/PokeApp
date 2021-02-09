//
//  DetailBuilder.swift
//  PokeApp
//
//  Created by Luis Costa on 08/02/2021.
//

import UIKit

final class DetailBuilder {
    private var viewModel: DetailViewModelProtocol?
    
    func setViewModel(_ viewModel: DetailViewModelProtocol) -> Self {
        self.viewModel = viewModel
        return self
    }

    func build() -> UIViewController {
        guard
            let viewModel = viewModel else {
            fatalError("Missing dependecies")
        }
        
        return DetailViewController(viewModel: viewModel)
    }
}
