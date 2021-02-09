//
//  MainViewController.swift
//  PokeApp
//
//  Created by Luis Costa on 08/02/2021.
//

import UIKit

class MainViewController: UIViewController {
    private lazy var mainView: MainView = {
        let view = MainView(buttonAction: { [weak self] in
            guard let self = self else { return }
            self.navigator.navigateToDetail(from: self)
        })
        view.isHidden = true
        return view
    }()
    
    private let loadingView = LoadingView()
    
    private let viewModel: MainViewModelProtocol
    private let navigator: NavigatorProtocol
    
    init(viewModel: MainViewModelProtocol,
         navigator: NavigatorProtocol) {
        self.viewModel = viewModel
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        fetchData()
    }
    
    // MARK: - Private Funtions
    
    private func addSubviews() {
        view.addSubview(mainView)
        view.addSubview(loadingView)
    }
    
    private func addConstraints() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        let rightButtonItem = UIBarButtonItem(title: "New Random Pokemon", style: .plain, target: self, action: #selector(didTapNewPokemon))
        navigationItem.setRightBarButton(rightButtonItem, animated: true)
    }
    
    private func fetchData() {
        showLoading(isShowing: true)
        viewModel.fetchMainData(then: { [weak self] result in
            switch result {
            case let .success(viewModel):
                self?.updateUI(with: viewModel)
            case .failure:
                self?.presentAlert()
            }
        })
    }
    
    private func updateUI(with viewModel: PokemonMainViewModel) {
        mainView.configure(with: .init(from: viewModel))
        showLoading(isShowing: false)
    }
    
    private func showLoading(isShowing: Bool) {
        self.mainView.isHidden = isShowing
        self.loadingView.isHidden = !isShowing
        self.navigationItem.rightBarButtonItem?.isEnabled = !isShowing
        isShowing ? self.loadingView.startAnimation() : self.loadingView.stopAnimation()
        self.navigationItem.rightBarButtonItem?.isEnabled = !isShowing
    }
    
    @objc private func didTapNewPokemon() {
        navigationItem.rightBarButtonItem?.isEnabled = false
        showLoading(isShowing: true)
        viewModel.fetchMainData(then: { [weak self] result in
            switch result {
            case let .success(viewModel):
                self?.updateUI(with: viewModel)
            case .failure:
                self?.presentAlert()
            }
        })
    }
    
    func presentAlert() {
        let alert = UIAlertController(title: Strings.alertTitle, message: Strings.alertMessage, preferredStyle: .alert)
        alert.addAction(.init(title: Strings.alertButtonTitle, style: .default, handler: { [weak self] _ in
            self?.fetchData()
        }))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Constants

extension MainViewController {
    struct Constants {
        static let animationInterval: TimeInterval = 0.3
    }
    
    struct Strings {
        static let alertTitle = "Sorry 😢"
        static let alertMessage = "Unable to fetch your favorite pokemon"
        static let alertButtonTitle = "Try again"
    }
}

// MARK: - Helper

private extension MainView.ViewModel {
    init(from viewModel: PokemonMainViewModel) {
        self.init(imageURL: viewModel.imgURL, name: viewModel.name)
    }
}
