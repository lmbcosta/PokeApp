//
//  MainView.swift
//  PokeApp
//
//  Created by Luis Costa on 08/02/2021.
//

import UIKit
import Kingfisher

final class MainView: UIView {
    private let buttonAction: () -> Void
    
    private let avatarView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: Constants.fontSize, weight: .bold)
        label.textColor = .blue
        return label
    }()
    
    private lazy var detailButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.buttonRadius
        button.layer.masksToBounds = true
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.setTitle(Strings.buttonTitle, for: .highlighted)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.8), for: .highlighted)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    init(buttonAction: @escaping () -> Void) {
        self.buttonAction = buttonAction
        super.init(frame: .zero)
        backgroundColor = .white
        addSubsviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubsviews() {
        addSubview(avatarView)
        addSubview(nameLabel)
        addSubview(detailButton)
    }
    
    private func addConstraints() {
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarView.heightAnchor.constraint(equalToConstant: Constants.avatarViewSize.height),
            avatarView.widthAnchor.constraint(equalToConstant: Constants.avatarViewSize.width)
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.nameLabelInsets.left),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.nameLabelInsets.right),
            nameLabel.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: Constants.nameLabelInsets.bottom)
        ])
        
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            detailButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.buttonOffset),
            detailButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize.height),
            detailButton.widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.buttonSize.width)
        ])
    }
    
    @objc private func didTapButton() {
        buttonAction()
    }
}

extension MainView {
    struct Constants {
        static let buttonRadius: CGFloat = buttonSize.height / 2
        static let buttonSize: CGSize = .init(width: 200, height: 50)
        static let buttonOffset: CGFloat = -100.0
        static let avatarViewSize: CGSize = .init(width: 150, height: 150)
        static let nameLabelInsets: UIEdgeInsets = .init(top: 0, left: 20, bottom: 50, right: -20)
        static let fontSize: CGFloat = 20
    }
    
    struct Strings {
        static let buttonTitle: String = "See %@ Details"
    }
}

extension MainView {
    struct ViewModel {
        let imageURL: URL
        let name: String
    }
    
    func configure(with viewModel: ViewModel) {
        let name = viewModel.name.capitalized
        nameLabel.text = name
        avatarView.kf.setImage(with: viewModel.imageURL)
        detailButton.setTitle(String(format: Strings.buttonTitle, name), for: .normal)
        detailButton.setTitle(String(format: Strings.buttonTitle, name), for: .highlighted)
    }
}


