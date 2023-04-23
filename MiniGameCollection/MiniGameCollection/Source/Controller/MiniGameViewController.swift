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

        configureNavigationBar()
    }

    private func configureNavigationBar() {
        let informationButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"),
                                                primaryAction: makePresentInformationAction())

        navigationItem.title = game.name
        navigationItem.rightBarButtonItem = informationButton
    }

    private func makePresentInformationAction() -> UIAction {
        let presentInformationAction = UIAction { [weak self] _ in
            let informationViewController = InformationViewController()

            informationViewController.configureTextView(with: self?.game.description)
            self?.present(informationViewController, animated: true)
        }

        return presentInformationAction
    }
}
