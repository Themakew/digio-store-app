//
//  DetailViewController.swift
//  DigioStore
//
//  Created by Ruyther Costa on 11/01/23.
//

import Kingfisher
import RxSwift
import UIKit

final class DetailViewController: UIViewController {

    // MARK: - Private Properties

    private let disposeBag = DisposeBag()
    private let viewModel: DetailViewModelProtocol
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
        $0.contentMode = .scaleAspectFit
    }

    private let descriptionLabel = UILabel(translateMask: false).apply {
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.tintColor = .black
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }

    private let backNavButton = UIButton(type: .system).apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .black
        $0.setTitle("Voltar", for: .normal)
    }

    // MARK: - Initializers

    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindRx()

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backNavButton)
    }

    // MARK: - Private Methods

    private func bindRx() {
        viewModel.output.titleText
            .drive(rx.title)
            .disposed(by: disposeBag)

        viewModel.output.descriptionText
            .drive(descriptionLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.output.image
            .drive(onNext: { [weak self] urlString in
                self?.thumbnailImage.kf.setImage(with: URL(string: urlString))
            })
            .disposed(by: disposeBag)

        backNavButton.rx.tap
            .bind(to: viewModel.input.dismissScreen)
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewCode Extension

extension DetailViewController: ViewCode {
    func buildViewHierarchy() {
        view.addSubview(itemBackgroundView)
        itemBackgroundView.addSubview(thumbnailImage)
        view.addSubview(descriptionLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            itemBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            itemBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            itemBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            itemBackgroundView.heightAnchor.constraint(equalToConstant: 150),

            thumbnailImage.topAnchor.constraint(equalTo: itemBackgroundView.topAnchor),
            thumbnailImage.leadingAnchor.constraint(equalTo: itemBackgroundView.leadingAnchor),
            thumbnailImage.trailingAnchor.constraint(equalTo: itemBackgroundView.trailingAnchor),
            thumbnailImage.bottomAnchor.constraint(equalTo: itemBackgroundView.bottomAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: thumbnailImage.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
    }
}

#if DEBUG

// MARK: - DetailViewController Extension To Expose Private Properties

extension DetailViewController {
    func getDescriptionLabel() -> UILabel {
        return descriptionLabel
    }

    func getBackNavButton() -> UIButton {
        return backNavButton
    }
}
#endif
