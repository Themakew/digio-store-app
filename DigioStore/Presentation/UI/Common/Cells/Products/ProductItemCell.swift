//
//  ProductItemCell.swift
//  DigioStore
//
//  Created by Ruyther Costa on 11/01/23.
//

import Kingfisher
import UIKit

final class ProductItemCell: UICollectionViewCell {

    // MARK: - Private Properties

    private let itemBackgroundView = UIView(translateMask: false).apply {
        $0.layer.cornerRadius = 10
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 2
        $0.layer.shouldRasterize = true
        $0.backgroundColor = .white
    }

    private let thumbnailImage = UIImageView(translateMask: false).apply {
        $0.contentMode = .scaleAspectFit
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

extension ProductItemCell: ViewCode {
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
            itemBackgroundView.heightAnchor.constraint(equalToConstant: 100),
            itemBackgroundView.widthAnchor.constraint(equalToConstant: 100),

            thumbnailImage.topAnchor.constraint(equalTo: itemBackgroundView.topAnchor, constant: 20),
            thumbnailImage.leadingAnchor.constraint(equalTo: itemBackgroundView.leadingAnchor, constant: 20),
            thumbnailImage.trailingAnchor.constraint(equalTo: itemBackgroundView.trailingAnchor, constant: -20),
            thumbnailImage.bottomAnchor.constraint(equalTo: itemBackgroundView.bottomAnchor, constant: -20),
        ])
    }
}

// MARK: - Configuration Extension

extension ProductItemCell: Configurable {
    typealias Configuration = ProductEntity

    func configure(content: Configuration) {
        if let urlString = content.imageURL,
           let url = URL(string: urlString) {
            thumbnailImage.kf.setImage(with: url, placeholder: Images.default_image)
        }
    }
}
