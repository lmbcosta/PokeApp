//
//  AvatarCell.swift
//  PokeApp
//
//  Created by Luis Costa on 09/02/2021.
//

import UIKit
import Kingfisher

final class AvatarCell: UICollectionViewCell {
    static let cellIdentifier = "AvatarCell"
    private let avatarImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(avatarImageView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with url: URL?) {
        avatarImageView.kf.setImage(with: url)
    }
    
    private func addConstraints() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.imageViewSize.height),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.imageViewSize.width),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}

extension AvatarCell {
    struct Constants {
        static let imageViewSize: CGSize = .init(width: 100, height: 100)
    }
}
