//
//  SpotlightCell.swift
//  DigioStore
//
//  Created by Ruyther Costa on 11/01/23.
//

import RxRelay
import RxSwift
import UIKit

final class SpotlightCell: UICollectionViewCell {

    // MARK: - Private Properties

    private var connectedBag = DisposeBag()

    private let dataSource = PublishRelay<[SpotlightEntity]>()
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

extension SpotlightCell: ViewCode {
    func buildViewHierarchy() {
        contentView.addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            contentView.heightAnchor.constraint(equalToConstant: 200),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
        ])
    }

    func setupAdditionalConfiguration() {
        collectionView.register(cellClass: SpotlightItemCell.self)
    }
}

// MARK: - Configuration Extension

extension SpotlightCell: Configurable {
    typealias Configuration = HomeSpotlightSection

    func configure(content: Configuration) {
        connectedBag = DisposeBag()

        dataSource
            .bind(to: collectionView.rx.items) { collectionView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeue(
                    cellClass: SpotlightItemCell.self,
                    indexPath: indexPath
                ) as SpotlightItemCell

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
