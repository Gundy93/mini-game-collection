//
//  RockSissorsPaperViewController.swift
//  MiniGameCollection
//
//  Created by Gundy on 2023/05/08.
//

import UIKit

final class RockSissorsPaperViewController: MiniGameViewController {

    private typealias Cell = RockSissorsPaperCollectionViewCell

    let handShapes = ["✊", "✌️", "🖐️"]
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
    var didScrollToMiddleItem = false
    var willDisplaying = 3

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        carouselCollectionView.scrollToItem(at: IndexPath(item: 1,
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
        configureLayout()
    }

    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        let carouselStackView = UIStackView(axis: .horizontal, spacing: 20, alignment: .center, distribution: .fill)
        let leftArrowImageView = UIImageView(image: UIImage(systemName: "arrowtriangle.left.fill"), tintColor: UIColor.systemCyan)
        let rightArrowImageView = UIImageView(image: UIImage(systemName: "arrowtriangle.right.fill"), tintColor: UIColor.systemCyan)

        view.addSubview(carouselStackView)
        [leftArrowImageView, carouselCollectionView, rightArrowImageView].forEach { subview in
            carouselStackView.addArrangedSubview(subview)
        }
        carouselStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            carouselStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            carouselStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            carouselStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            carouselStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            carouselCollectionView.heightAnchor.constraint(equalTo: carouselStackView.heightAnchor)
        ])
    }
}

extension RockSissorsPaperViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return handShapes.count + 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let handShape = handShapes[indexPath.item % 3]
        guard let cell = carouselCollectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifiet,
                                                                    for: indexPath) as? Cell else {
            return Cell()
        }

        cell.configure(with: handShape)

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
