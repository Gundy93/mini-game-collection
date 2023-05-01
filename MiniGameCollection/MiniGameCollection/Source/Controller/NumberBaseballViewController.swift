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

    private var isEnd: Bool = false {
        didSet {
            if isEnd {
                guessingButton?.isHidden = true
                replayButton?.isHidden = false
                containerStackView.arrangedSubviews.compactMap({ $0 as? UIStackView }).forEach { stackView in
                    stackView.arrangedSubviews.compactMap({ $0 as? UIButton }).forEach { button in
                        button.isEnabled = false
                    }
                }
            } else {
                guessingButton?.isHidden = false
                replayButton?.isHidden = true
                containerStackView.arrangedSubviews.compactMap({ $0 as? UIStackView }).forEach { stackView in
                    stackView.arrangedSubviews.compactMap({ $0 as? UIButton }).forEach { button in
                        button.isEnabled = true
                    }
                }
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
        configureNumberButtons()
        configureReplayButton()
        configureGuessingButton()
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

    private func configureNumberButtons() {
        for section in 0...1 {
            let stackView = UIStackView(axis: .horizontal, spacing: 8)

            for index in 0...4 {
                let number = section * 5 + index
                let action = makeInputNumberAction(of: number)
                let button = UIButton(primaryAction: action)

                button.setTitle("\(number)", for: .normal)
                button.titleLabel?.font = .preferredFont(forTextStyle: .title2)
                button.setTitleColor(.label, for: .normal)
                button.setTitleColor(.systemGray4, for: .disabled)
                button.backgroundColor = .systemGray5
                button.layer.cornerRadius = 20
                stackView.addArrangedSubview(button)
            }
            containerStackView.addArrangedSubview(stackView)
            stackView.heightAnchor.constraint(equalTo: answerStackView.heightAnchor, multiplier: 0.4).isActive = true
        }
    }

    private func makeInputNumberAction(of number: Int) -> UIAction {
        let action = UIAction { [weak self] _ in
            var isExistNumber = true

            for place in 0...2 {
                if self?.inputedAnswer[place] == number {
                    let button = self?.answerStackView.arrangedSubviews[place] as? UIButton

                    button?.setTitle("_", for: .normal)
                    isExistNumber = false
                    self?.inputedAnswer[place] = nil
                    break
                }
            }
            if isExistNumber {
                guard let values = self?.inputedAnswer.values,
                      values.count < 3 else { return }

                for place in 0...2 {
                    if self?.inputedAnswer[place] == nil {
                        let button = self?.answerStackView.arrangedSubviews[place] as? UIButton

                        button?.setTitle("\(number)", for: .normal)
                        self?.inputedAnswer[place] = number
                        break
                    }
                }
            }
        }

        return action
    }

    private func configureReplayButton() {
        let action = makeReplayAction()
        let button = UIButton(primaryAction: action)

        button.isHidden = true
        button.setTitle("다시하기", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        button.setContentHuggingPriority(.required, for: .vertical)
        replayButton = button
        containerStackView.addArrangedSubview(button)
    }

    private func makeReplayAction() -> UIAction {
        let action = UIAction { [weak self] _ in
            self?.resetGame()
        }
        return action
    }

    private func resetGame() {
        isEnd = false
        logs = []
        logTableView.reloadData()
        remainingCount = 9
        goal = makeRandomNumbers(in: 0...9)
    }

    private func configureGuessingButton() {
        let action = makeGuessingAction()
        let button = UIButton(primaryAction: action)

        button.isEnabled = false
        button.setTitle("확인하기", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.systemGray, for: .disabled)
        button.setContentHuggingPriority(.required, for: .vertical)
        guessingButton = button
        containerStackView.addArrangedSubview(button)
    }

    private func makeGuessingAction() -> UIAction {
        let action = UIAction { [weak self] _ in
            guard let userNumbers = self?.joinUserNumbers(),
                  userNumbers.count == 3 else {
                return
            }
            guard let goal = self?.goal,
                  let comparedResult = self?.compare(goal, and: userNumbers) else { return }

            self?.showResultAlert(comparedResult.strike, comparedResult.ball)
        }
        return action
    }

    private func joinUserNumbers() -> [Int] {
        var numbers = [Int]()

        for place in 0...2 {
            guard let number = inputedAnswer[place] else { return numbers }

            numbers.append(number)
        }

        return numbers
    }

    private func compare(_ goal: [Int],and numbers: [Int]) -> (strike: Int, ball: Int) {
        var strike = 0
        var ball = 0

        for index in 0...2 {
            if numbers[index] == goal[index] {
                strike += 1
            } else if goal.contains(numbers[index]) {
                ball += 1
            }
        }

        return (strike, ball)
    }

    private func showResultAlert(_ strikeCount: Int, _ ballCount: Int) {
        guard var message = makeResultMessage(strikeCount, ballCount) else { return }
        let Judgment = judgeGame(strikeCount)
        if Judgment.continuity == false,
           let winner = Judgment.winner {
            message += """
                        Game Set!
                       Winner: \(winner)
                       """
            isEnd = true
        }

        let completion: (UIAlertAction) -> Void = { [weak self] _ in
            guard let remainingCount = self?.remainingCount,
                  let triedNumbers = self?.joinUserNumbers() else { return }

            self?.logs.append("\(10 - remainingCount)회차: \(triedNumbers) - " + message.split(separator: "!")[0])
            self?.logTableView.reloadData()
            self?.remainingCount -= 1
            for index in 0...2 {
                let button = self?.answerStackView.arrangedSubviews[index] as? UIButton

                button?.setTitle("_", for: .normal)
                self?.inputedAnswer[index] = nil
            }
            guard let contentHeight = self?.logTableView.contentSize.height,
                  let boundsHeight = self?.logTableView.bounds.height,
                  contentHeight > boundsHeight else { return }
            self?.logTableView.layoutIfNeeded()
            self?.logTableView.setContentOffset(CGPoint(x: 0, y: contentHeight - boundsHeight), animated: true)
        }

        showAlert(message: message, completion: completion)
    }

    private func makeResultMessage(_ strikeCount: Int, _ ballCount: Int) -> String? {
        switch (strikeCount, ballCount) {
        case (0, 0):
            return "Out!"
        case (_, 0):
            return "\(strikeCount) Strike!"
        case (0, _):
            return "\(ballCount) Ball!"
        default:
            return nil
        }
    }

    private func judgeGame(_ strikeCount: Int) -> (continuity: Bool, winner: Player?) {
        if strikeCount == 3 {
            return (false, .user)
        }
        if remainingCount == 1 {
            return (false, .computer)
        }
        return (true, nil)
    }

    private func showAlert(title: String? = nil, message: String? = nil, completion: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let doneAction = UIAlertAction(title: "확인", style: .default, handler: completion)

        alertController.addAction(doneAction)
        present(alertController, animated: true)
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
