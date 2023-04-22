//
//  MiniGameListViewController.swift
//  MiniGameCollection
//
//  Created by Gundy on 2023/04/17.
//

import UIKit

class MiniGameListViewController: UIViewController {

    private var miniGames: [Playable] = []
    private var miniGamesCollectionView: UICollectionView = {
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)

        return UICollectionView(frame: .zero, collectionViewLayout: listLayout)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    private func configure() {
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
        view.addSubview(miniGamesCollectionView)
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            miniGamesCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            miniGamesCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            miniGamesCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            miniGamesCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
}
