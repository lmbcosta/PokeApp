//
//  DetailViewController.swift
//  PokeApp
//
//  Created by Luis Costa on 08/02/2021.
//

import UIKit

final class DetailViewController: UIViewController {
    private let viewModel: DetailViewModelProtocol
    
    private lazy var dataSource =
        CollectionViewDataSource(viewModel: viewModel,
                                 cellWidth: view.bounds.width)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero,
                                    collectionViewLayout: layout)
        view.dataSource = dataSource
        view.delegate = dataSource
        view.backgroundColor = .lightGray
        return view
    }()
    
    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        dataSource.registerReusableViews(for: collectionView)
        addSubviews()
        addConstraints()
    }
    
    // MARK: - Private Functions
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    private func addConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
        
    
}
