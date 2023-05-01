//
//  NumberBaseballViewController.swift
//  MiniGameCollection
//
//  Created by Gundy on 2023/04/23.
//

import UIKit

final class NumberBaseballViewController: MiniGameViewController {

    private let containerStackView = UIStackView(axis: .vertical, spacing: 20, distribution: .fill)

    private let remainingCountLabel = UILabel(text: "잔여기회: 9", font: .preferredFont(forTextStyle: .headline), textAlignment: .center)

    private let logTableView = UITableView()

    private let answerStackView: UIStackView = UIStackView(axis: .horizontal, spacing: 20)

    private var guessingButton: UIButton?

    private var replayButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    private func configure() {
        configureUI()
    }

    private func configureUI() {
        configureLayout()
    }

    private func configureLayout() {
        let subviews = [remainingCountLabel, logTableView, answerStackView]

        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        answerStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerStackView)
        subviews.forEach { subview in
            containerStackView.addArrangedSubview(subview)
        }

        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            containerStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            containerStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            containerStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),

            logTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
        ])

        remainingCountLabel.setContentHuggingPriority(.required, for: .vertical)
    }
}
