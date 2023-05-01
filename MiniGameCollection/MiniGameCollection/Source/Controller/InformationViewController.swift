//
//  InformationViewController.swift
//  MiniGameCollection
//
//  Created by Gundy on 2023/04/23.
//

import UIKit

final class InformationViewController: UIViewController {

    private var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()

        navigationBar.translatesAutoresizingMaskIntoConstraints = false

        return navigationBar
    }()

    private var descriptionScrollView: UIScrollView = {
        let scrollView = UIScrollView()

        scrollView.translatesAutoresizingMaskIntoConstraints = false

        return scrollView
    }()

    private var descriptionLabel: UILabel = {
        let label = UILabel(font: .preferredFont(forTextStyle: .headline), textAlignment: .center)

        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    private func configure() {
        configureNavigationBar()
        convigureUI()
    }

    private func configureNavigationBar() {
        let navigationItem = UINavigationItem(title: "게임 설명")
        let dismissButton = UIBarButtonItem(systemItem: .done, primaryAction: makeDismissAction())

        navigationItem.rightBarButtonItem = dismissButton
        navigationBar.items?.append(navigationItem)
    }

    private func makeDismissAction() -> UIAction {
        let dismissAction = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }

        return dismissAction
    }

    private func convigureUI() {
        view.backgroundColor = .systemBackground
        configureLayout()
    }

    private func configureLayout() {
        let subviews = [navigationBar, descriptionScrollView]

        subviews.forEach {
            view.addSubview($0)
        }
        descriptionScrollView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            descriptionScrollView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 20),
            descriptionScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),

            descriptionLabel.topAnchor.constraint(equalTo: descriptionScrollView.contentLayoutGuide.topAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionScrollView.contentLayoutGuide.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionScrollView.frameLayoutGuide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionScrollView.frameLayoutGuide.trailingAnchor),
        ])
    }

    func configureLabel(with text: String?) {
        descriptionLabel.text = text
    }
}
