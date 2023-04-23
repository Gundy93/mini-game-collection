//
//  InformationViewController.swift
//  MiniGameCollection
//
//  Created by Gundy on 2023/04/23.
//

import UIKit

class InformationViewController: UIViewController {

    private var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()

        navigationBar.translatesAutoresizingMaskIntoConstraints = false

        return navigationBar
    }()

    private var descriptionTextView: UITextView = {
        let textView = UITextView()

        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false

        return textView
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
        let dismissButton = UIBarButtonItem(systemItem: .done)
        let dismissAction = UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }

        dismissButton.primaryAction = dismissAction
        navigationItem.rightBarButtonItem = dismissButton
        navigationBar.items?.append(navigationItem)
    }

    private func convigureUI() {
        view.backgroundColor = .systemBackground
        configureLayout()
    }

    private func configureLayout() {
        let subviews = [navigationBar, descriptionTextView]
        subviews.forEach {
            view.addSubview($0)
        }
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            descriptionTextView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 20),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20)
        ])
    }

    func configureTextView(with text: String) {
        descriptionTextView.text = text
    }
}
