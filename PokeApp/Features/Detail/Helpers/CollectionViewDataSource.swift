//
//  CollectionViewDataSource.swift
//  PokeApp
//
//  Created by Luis Costa on 09/02/2021.
//

import UIKit

final class CollectionViewDataSource: NSObject,
                                      UICollectionViewDataSource,
                                      UICollectionViewDelegateFlowLayout {
    private let viewModel: DetailViewModelProtocol
    private let cellWidth: CGFloat
    
    init(viewModel: DetailViewModelProtocol,
         cellWidth: CGFloat) {
        self.viewModel = viewModel
        self.cellWidth = cellWidth
        super.init()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems(for: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatarCell.cellIdentifier, for: indexPath) as? AvatarCell else {
                return .init()
            }
            cell.configure(with: viewModel.getUrlForImage())
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DescriptionCell.cellIdentifier, for: indexPath) as? DescriptionCell else {
            return .init()
        }
        let text = viewModel.getTextFor(item: indexPath.item, section: indexPath.section)
        cell.configure(text: text)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard
            kind == UICollectionView.elementKindSectionHeader,
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DescriptionSectionHeader.headerIdentifier, for: indexPath) as? DescriptionSectionHeader else {
            return .init()
        }
        let title = viewModel.getSectionTitle(section: indexPath.section) ?? ""
        sectionHeader.configure(text: title)
        return sectionHeader
    }
    
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return .init(width: cellWidth, height: Constants.avatarCellHeight)
        }
        
        return .init(width: cellWidth, height: Constants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard viewModel.getSectionTitle(section: section) != nil else {
            return .zero
        }
        
        return .init(width: cellWidth, height: Constants.sectionHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
    
    func registerReusableViews(for collectionView: UICollectionView) {
        collectionView.register(AvatarCell.self, forCellWithReuseIdentifier: AvatarCell.cellIdentifier)
        collectionView.register(DescriptionCell.self, forCellWithReuseIdentifier: DescriptionCell.cellIdentifier)
        collectionView.register(DescriptionSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DescriptionSectionHeader.headerIdentifier)
    }
}

extension CollectionViewDataSource {
    struct Constants {
        static let cellHeight: CGFloat = 30
        static let avatarCellHeight: CGFloat = 150
        static let sectionHeight: CGFloat = 50
        static let spacing: CGFloat = 1
    }
}
