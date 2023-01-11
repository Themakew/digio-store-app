//
//  ProductsCell.swift
//  DigioStore
//
//  Created by Ruyther Costa on 11/01/23.
//

import RxRelay
import RxSwift
import UIKit

final class ProductsCell: UICollectionViewCell {

    // MARK: - Private Properties

    private var connectedBag = DisposeBag()

    private let dataSource = PublishRelay<[ProductEntity]>()
    private let layout = UICollectionViewFlowLayout().apply {
        $0.scrollDirection = .horizontal
        $0.minimumInteritemSpacing = .zero
        $0.minimumLineSpacing = .zero
        $0.estimatedItemSize = CGSize(
            width: UIScreen.main.bounds.size.width,
            height: 100
        )
    }

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = true
        $0.backgroundColor = .white
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

extension ProductsCell: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            contentView.heightAnchor.constraint(equalToConstant: 150),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
        ])
    }

    func setupAdditionalConfiguration() {
        collectionView.register(cellClass: ProductItemCell.self)
    }
}

// MARK: - Configuration Extension

extension ProductsCell: Configurable {
    typealias Configuration = HomeProductSection

    func configure(content: Configuration) {
        connectedBag = DisposeBag()

        dataSource
            .bind(to: collectionView.rx.items) { collectionView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeue(
                    cellClass: ProductItemCell.self,
                    indexPath: indexPath
                ) as ProductItemCell

                cell.configure(content: element)
                return cell
            }
            .disposed(by: connectedBag)

        collectionView.rx.itemSelected
            .bind(to: content.itemSelectedObserver)
            .disposed(by: connectedBag)

        dataSource.accept(content.items)
    }
}
