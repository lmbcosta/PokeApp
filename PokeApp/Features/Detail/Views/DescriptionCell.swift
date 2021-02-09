//
//  DescriptionCell.swift
//  PokeApp
//
//  Created by Luis Costa on 09/02/2021.
//

import UIKit

final class DescriptionCell: UICollectionViewCell {
    static let cellIdentifier = "DescriptionCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.font
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.horizontalInset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.horizontalInset)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        self.titleLabel.text = text
    }
}

extension DescriptionCell {
    struct Constants {
        static let font = UIFont.systemFont(ofSize: 14, weight: .medium)
        static let horizontalInset: CGFloat = 12
        
    }
}
