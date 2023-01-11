//
//  CashCell.swift
//  DigioStore
//
//  Created by Ruyther Costa on 11/01/23.
//

import UIKit

final class CashCell: UICollectionViewCell {

    // MARK: - Private Properties

    private let container = UIView(translateMask: false)
    private let itemBackgroundView = UIView(translateMask: false).apply {
        $0.layer.cornerRadius = 10
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowOffset = .zero
        $0.layer.shadowRadius = 5
        $0.layer.shouldRasterize = true
        $0.backgroundColor = .red
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

extension CashCell: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(container)
        container.addSubview(itemBackgroundView)
        itemBackgroundView.addSubview(thumbnailImage)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.heightAnchor.constraint(equalToConstant: 150),

            itemBackgroundView.topAnchor.constraint(equalTo: container.topAnchor, constant: 15),
            itemBackgroundView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            itemBackgroundView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15),
            itemBackgroundView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -15),

            thumbnailImage.topAnchor.constraint(equalTo: itemBackgroundView.topAnchor),
            thumbnailImage.leadingAnchor.constraint(equalTo: itemBackgroundView.leadingAnchor),
            thumbnailImage.trailingAnchor.constraint(equalTo: itemBackgroundView.trailingAnchor),
            thumbnailImage.bottomAnchor.constraint(equalTo: itemBackgroundView.bottomAnchor),

            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
        ])
    }
}

// MARK: - Configuration Extension

extension CashCell: Configurable {
    typealias Configuration = HomeCashSection

    func configure(content: Configuration) {
        if let urlString = content.object.bannerURL,
           let url = URL(string: urlString) {
            thumbnailImage.kf.setImage(with: url, placeholder: Images.default_image)
        }
    }
}
