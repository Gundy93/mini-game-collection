//
//  MiniGameListViewController.swift
//  MiniGameCollection
//
//  Created by Gundy on 2023/04/17.
//

import UIKit

class MiniGameListViewController: UIViewController {

    private var miniGames: [Playable] = [NumberBaseball(), RockSissorsPaper()]
    private var miniGamesCollectionView: UICollectionView = {
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MiniGamesCollectionViewCell.self,
                                forCellWithReuseIdentifier: MiniGamesCollectionViewCell.identifiet)

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    private func configure() {
        miniGamesCollectionView.dataSource = self
        miniGamesCollectionView.delegate = self
        configureNavigationBar()
        configureUI()
    }

    private func configureNavigationBar() {
        navigationItem.title = "Mini Games Collection"
    }

    private func configureUI() {
        view.backgroundColor = .systemBackground
        configureLayout()
    }

    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide

        view.addSubview(miniGamesCollectionView)
        NSLayoutConstraint.activate([
            miniGamesCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            miniGamesCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            miniGamesCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            miniGamesCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
}

extension MiniGameListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return miniGames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = miniGamesCollectionView.dequeueReusableCell(withReuseIdentifier: MiniGamesCollectionViewCell.identifiet, for: indexPath)
        guard let cell = cell as? UICollectionViewListCell else { return cell }
        var content = cell.defaultContentConfiguration()
        let item = miniGames[indexPath.item]

        content.image = UIImage(systemName: item.imageName)
        content.text = item.name
        content.imageProperties.tintColor = .label
        cell.contentConfiguration = content
        cell.accessories.append(.disclosureIndicator())

        return cell
    }
}

extension MiniGameListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let miniGame = miniGames[indexPath.item]
        let miniGameViewController = makeMiniGameViewController(game: miniGame)

        navigationController?.pushViewController(miniGameViewController, animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    func makeMiniGameViewController(game: Playable) -> MiniGameViewController {
        switch game.name {
        case "숫자 야구":
            return NumberBaseballViewController(game: game)
        default:
            return MiniGameViewController(game: game)
        }
    }
}
