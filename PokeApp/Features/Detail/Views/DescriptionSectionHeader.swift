//
//  DescriptionSectionHeader.swift
//  PokeApp
//
//  Created by Luis Costa on 09/02/2021.
//

import UIKit

final class DescriptionSectionHeader: UICollectionReusableView {
    static let headerIdentifier = "DescriptionSectionHeader"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.font
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .blue
        addSubview(titleLabel)
        addContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        self.titleLabel.text = text
    }
    
    private func addContraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalInset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalInset)
        ])
    }
}

extension DescriptionSectionHeader {
    struct Constants {
        static let font = UIFont.systemFont(ofSize: 18, weight: .bold)
        static let horizontalInset: CGFloat = 12
        
    }
}
