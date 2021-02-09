//
//  LoadingView.swift
//  PokeApp
//
//  Created by Luis Costa on 08/02/2021.
//

import UIKit

final class LoadingView: UIView {
    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = .blue
        view.startAnimating()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stopAnimation() {
        activityIndicatorView.stopAnimating()
    }
    
    func startAnimation() {
        activityIndicatorView.startAnimating()
    }
    
    // MARK: - Private Functions
    
    private func addSubviews() {
        addSubview(activityIndicatorView)
        addConstraints()
    }
    
    private func addConstraints() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.widthAnchor.constraint(equalToConstant: Constants.activityIndicatorSize.width),
            activityIndicatorView.heightAnchor.constraint(equalToConstant: Constants.activityIndicatorSize.height),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

// MARK: - Constants

private extension LoadingView {
    struct Constants {
        static let activityIndicatorSize = CGSize(width: 40, height: 40)
    }
}
