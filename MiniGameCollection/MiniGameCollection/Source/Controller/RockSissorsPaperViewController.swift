//
//  RockSissorsPaperViewController.swift
//  MiniGameCollection
//
//  Created by Gundy on 2023/05/08.
//

import UIKit

final class RockSissorsPaperViewController: MiniGameViewController {

    private typealias Cell = RockSissorsPaperCollectionViewCell

    let containerStackView = UIStackView(axis: .vertical,
                                         alignment: .center,
                                         distribution: .equalSpacing)
    let computerLabel = UILabel(text: "Computer",
                                font: .preferredFont(forTextStyle: .headline), textAlignment: .center)
    let computerHandView = UIView()
    let computerHandLabel = UILabel(text: "❔",
                                    font: .preferredFont(forTextStyle: .largeTitle),
                                    textAlignment: .center)
    let carouselCollectionView: UICollectionView = {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical

        let layout = UICollectionViewCompositionalLayout(sectionProvider: {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1.0)),
                subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered

            return section
        }, configuration: config)
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(Cell.self,
                                forCellWithReuseIdentifier: Cell.identifiet)

        return collectionView
    }()
    let userLabel = UILabel(text: "User",
                            font: .preferredFont(forTextStyle: .headline), textAlignment: .center)
    let lockInButton: UIButton = {
        let button = UIButton(primaryAction: nil)

        button.setTitle("가위바위보", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.tintColor = .systemCyan

        return button
    }()
    var didScrollToMiddleItem = false
    var willDisplaying = Int()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        carouselCollectionView.scrollToItem(at: IndexPath(item: 3,
                                                          section: 0),
                                            at: .centeredHorizontally,
                                            animated: false)
        didScrollToMiddleItem = true
    }

    private func configure() {
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        configureUI()
    }

    private func configureUI() {
        computerHandLabel.backgroundColor = .systemCyan
        computerHandLabel.layer.cornerRadius = 20
        computerHandLabel.clipsToBounds = true
        configureLayout()
    }

    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        let carouselStackView = UIStackView(axis: .horizontal, spacing: 20, alignment: .center, distribution: .fill)
        let leftArrowImageView = UIImageView(image: UIImage(systemName: "arrowtriangle.left.fill"), tintColor: UIColor.systemCyan)
        let rightArrowImageView = UIImageView(image: UIImage(systemName: "arrowtriangle.right.fill"), tintColor: UIColor.systemCyan)

        [leftArrowImageView, carouselCollectionView, rightArrowImageView].forEach { subview in
            carouselStackView.addArrangedSubview(subview)
        }
        [leftArrowImageView, rightArrowImageView].forEach { imageView in
            imageView.contentMode = .scaleAspectFit
            imageView.setContentHuggingPriority(.required, for: .horizontal)
        }
        computerHandView.addSubview(computerHandLabel)
        [computerLabel, computerHandView, carouselStackView, userLabel, lockInButton].forEach { subview in
            containerStackView.addArrangedSubview(subview)
        }
        view.addSubview(containerStackView)
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        computerHandLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            computerHandView.heightAnchor.constraint(equalTo: carouselStackView.heightAnchor),
            computerHandView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.4),
            computerHandView.widthAnchor.constraint(equalTo: carouselCollectionView.widthAnchor),
            computerHandLabel.topAnchor.constraint(equalTo: computerHandView.topAnchor, constant: 20),
            computerHandLabel.leadingAnchor.constraint(equalTo: computerHandView.leadingAnchor, constant: 20),
            computerHandLabel.trailingAnchor.constraint(equalTo: computerHandView.trailingAnchor, constant: -20),
            computerHandLabel.bottomAnchor.constraint(equalTo: computerHandView.bottomAnchor, constant: -20),
            carouselStackView.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor, constant: 20),
            carouselStackView.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor, constant: -20),
            carouselCollectionView.heightAnchor.constraint(equalTo: carouselStackView.heightAnchor)
        ])
    }
}

extension RockSissorsPaperViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let handShape = RockSissorsPaper.HandShape(rawValue: indexPath.item % 3),
              let cell = carouselCollectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifiet,
                                                                    for: indexPath) as? Cell else {
            return Cell()
        }

        cell.configure(with: "\(handShape)")

        return cell
    }
}

extension RockSissorsPaperViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        willDisplaying = indexPath.item
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard didScrollToMiddleItem else { return }
        switch (indexPath.item, willDisplaying) {
        case (1, 0):
            collectionView.scrollToItem(at: IndexPath(item: 3,
                                                      section: 0),
                                        at: .centeredHorizontally,
                                        animated: false)
        case (3, 4):
            collectionView.scrollToItem(at: IndexPath(item: 1,
                                                      section: 0),
                                        at: .centeredHorizontally,
                                        animated: false)
        default:
            break
        }
    }
}
