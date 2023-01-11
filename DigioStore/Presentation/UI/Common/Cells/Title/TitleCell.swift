//
//  TitleCell.swift
//  DigioStore
//
//  Created by Ruyther Costa on 11/01/23.
//

import UIKit

final class TitleCell: UICollectionViewCell {

    // MARK: - Private Properties

    private let titleLabel = UILabel(translateMask: false).apply {
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.tintColor = .black
        $0.textAlignment = .left
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CodeView Extension

extension TitleCell: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(titleLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
        ])
    }
}

// MARK: - Configuration Extension

extension TitleCell: Configurable {
    typealias Configuration = TitleEntity

    func configure(content: Configuration) {
        titleLabel.text = content.title
    }
}
