//
//  NumberBaseballViewController.swift
//  MiniGameCollection
//
//  Created by Gundy on 2023/04/23.
//

import UIKit

final class NumberBaseballViewController: MiniGameViewController {

    private var goal: [Int]?

    private var remainingCount = 9 {
        didSet {
            remainingCountLabel.text = "잔여기회: \(remainingCount)"
        }
    }

    private var logs = [String]()

    private var inputedAnswer = [Int: Int]() {
        didSet {
            if inputedAnswer.values.count == 3 {
                guessingButton?.isEnabled = true
            } else {
                guessingButton?.isEnabled = false
            }
        }
    }

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
        configureInitialState()
        configureUI()
    }

    private func configureInitialState() {
        goal = makeRandomNumbers(in: 0...9)
        logTableView.dataSource = self
        logTableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifiet)
    }

    private func makeRandomNumbers(in range: ClosedRange<Int>, count: Int = 3) -> [Int] {
        let randomNumbers = range.shuffled()

        return Array(randomNumbers[0..<count])
    }

    private func configureUI() {
        configureLayout()
        configureButtons()
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

    private func configureButtons() {
        configureAnswerButtons()
    }

    private func configureAnswerButtons() {
        for index in 0...2 {
            let action = UIAction { [weak self] _ in
                let button = self?.answerStackView.arrangedSubviews[index] as? UIButton

                button?.setTitle("_", for: .normal)
                self?.inputedAnswer[index] = nil
            }
            let button = UIButton(primaryAction: action)

            button.setTitle("_", for: .normal)
            button.titleLabel?.font = .preferredFont(forTextStyle: .largeTitle)
            button.titleLabel?.textAlignment = .center
            button.setTitleColor(.label, for: .normal)
            button.setTitleColor(.systemGray4, for: .disabled)
            answerStackView.addArrangedSubview(button)
        }
    }
}

extension NumberBaseballViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifiet) else { return TableViewCell() }
        var content = cell.defaultContentConfiguration()
        let log = logs[indexPath.item]

        content.text = log
        cell.contentConfiguration = content
        cell.selectionStyle = .none

        return cell
    }
}
