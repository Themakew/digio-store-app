//
//  SpotlightItemCell.swift
//  DigioStore
//
//  Created by Ruyther Costa on 11/01/23.
//

import Kingfisher
import UIKit

final class SpotlightItemCell: UICollectionViewCell {

    // MARK: - Private Properties

    private let itemBackgroundView = UIView(translateMask: false).apply {
        $0.layer.cornerRadius = 10
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowOffset = .zero
        $0.layer.shadowRadius = 5
        $0.layer.shouldRasterize = true
    }

    private let thumbnailImage = UIImageView(translateMask: false).apply {
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
        $0.contentMode = .scaleAspectFill
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

extension SpotlightItemCell: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(itemBackgroundView)
        itemBackgroundView.addSubview(thumbnailImage)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            itemBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            itemBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            itemBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            itemBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            itemBackgroundView.heightAnchor.constraint(equalToConstant: 150),
            itemBackgroundView.widthAnchor.constraint(equalToConstant: 300),

            thumbnailImage.topAnchor.constraint(equalTo: itemBackgroundView.topAnchor),
            thumbnailImage.leadingAnchor.constraint(equalTo: itemBackgroundView.leadingAnchor),
            thumbnailImage.trailingAnchor.constraint(equalTo: itemBackgroundView.trailingAnchor),
            thumbnailImage.bottomAnchor.constraint(equalTo: itemBackgroundView.bottomAnchor),
        ])
    }
}

// MARK: - Configuration Extension

extension SpotlightItemCell: Configurable {
    typealias Configuration = SpotlightEntity

    func configure(content: Configuration) {
        if let urlString = content.bannerURL,
           let url = URL(string: urlString) {
            thumbnailImage.kf.setImage(with: url, placeholder: Images.default_image)
        }
    }
}
