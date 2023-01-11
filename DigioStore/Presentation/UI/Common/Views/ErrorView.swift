//
//  ErrorView.swift
//  DigioStore
//
//  Created by Ruyther Costa on 11/01/23.
//

import RxGesture
import RxRelay
import RxSwift
import UIKit

final class ErrorView: UIView {

    // MARK: - Private Properties

    private let disposeBag = DisposeBag()
    private let containerView = UIView(translateMask: false)
    private let tryAgainBaseView = UIView(translateMask: false)
    private let mainStackView = UIStackView(translateMask: false).apply {
        $0.distribution = .fill
        $0.axis = .vertical
        $0.spacing = 7
    }

    private let stackView = UIStackView(translateMask: false).apply {
        $0.distribution = .fill
        $0.axis = .vertical
        $0.spacing = 27
    }

    private let messageErrorLabel = UILabel(translateMask: false).apply {
        $0.numberOfLines = 0
        $0.textColor = .black
        $0.textAlignment = .center
    }

    private let tryAgainButton = UIButton(type: .system).apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.tintColor = .black
        $0.isUserInteractionEnabled = true
        $0.imageView?.contentMode = .scaleAspectFit
    }

    private let tryAgainTextLabel = UILabel(translateMask: false).apply {
        $0.attributedText = NSAttributedString(
            string: "Title",
            attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue]
        )
        $0.textColor = .black
        $0.textAlignment = .center
        $0.isUserInteractionEnabled = true
    }

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    func setUpData(object: GenericErrorEntity) {
        messageErrorLabel.text = object.messageErrorText
        tryAgainTextLabel.text = object.buttonTitleText
        tryAgainButton.setImage(object.icon, for: .normal)

        backgroundColor = object.backgroudColor
    }
}

// MARK: - ViewCode Extension

extension ErrorView: ViewCode {
    func buildViewHierarchy() {
        addSubview(containerView)

        tryAgainBaseView.addSubview(tryAgainButton)

        mainStackView.addArrangedSubview(tryAgainBaseView)
        mainStackView.addArrangedSubview(tryAgainTextLabel)

        stackView.addArrangedSubview(messageErrorLabel)
        stackView.addArrangedSubview(mainStackView)

        containerView.addSubview(stackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),

            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

            tryAgainButton.topAnchor.constraint(equalTo: tryAgainBaseView.topAnchor),
            tryAgainButton.bottomAnchor.constraint(equalTo: tryAgainBaseView.bottomAnchor),
            tryAgainButton.heightAnchor.constraint(equalToConstant: 24),
            tryAgainButton.widthAnchor.constraint(equalToConstant: 24),
            tryAgainButton.centerXAnchor.constraint(equalTo: tryAgainBaseView.centerXAnchor),
            tryAgainButton.centerYAnchor.constraint(equalTo: tryAgainBaseView.centerYAnchor),
        ])
    }
}

// MARK: - Configuration Extension

extension ErrorView: Configurable {
    typealias Configuration = ErrorEntity

    func configure(content: Configuration) {
        setUpData(object: content.dataSource)

        let observable = Observable.of(
            tryAgainButton.rx.tap
                .asObservable(),
            tryAgainTextLabel.rx.tapGesture()
                .when(.recognized)
                .flatMap { _ in Observable.just(()) },
            mainStackView.rx.tapGesture()
                .when(.recognized)
                .flatMap { _ in Observable.just(()) }
        )
            .merge()

        observable
            .take(1)
            .bind(to: content.tryAgainObserver)
            .disposed(by: disposeBag)

        content.isShown
            .map { !$0 }
            .bind(to: rx.isHidden)
            .disposed(by: disposeBag)
    }
}
