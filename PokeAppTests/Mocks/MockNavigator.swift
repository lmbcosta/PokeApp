//
//  MockNavigator.swift
//  PokeAppTests
//
//  Created by Luis Costa on 11/02/2021.
//

import UIKit
@testable import PokeApp

final class MockNavigator: NavigatorProtocol {
    var isOnDetail = false
    
    func navigateToDetail(from viewController: UIViewController) {
        isOnDetail = true
    }
}
