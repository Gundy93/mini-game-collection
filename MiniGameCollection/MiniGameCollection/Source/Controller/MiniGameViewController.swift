//
//  MiniGameViewController.swift
//  MiniGameCollection
//
//  Created by Gundy on 2023/04/23.
//

import UIKit

class MiniGameViewController: UIViewController {

    let game: Playable

    init(game: Playable) {
        self.game = game

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    

    private func configure() {
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        navigationItem.title = game.name
    }
}
