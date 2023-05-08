//
//  RockSissorsPaperCollectionViewCell.swift
//  MiniGameCollection
//
//  Created by Gundy on 2023/05/08.
//

import UIKit

final class RockSissorsPaperCollectionViewCell: UICollectionViewCell {

    static let identifiet: String = String(describing: RockSissorsPaperCollectionViewCell.self)

    private let handShapeLabel = UILabel(font: .preferredFont(forTextStyle: .title1), textAlignment: .center)

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureViewHierarchy()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        backgroundColor = .systemGray6
        configureViewHierarchy()
    }

    private func configureViewHierarchy() {
        contentView.addSubview(handShapeLabel)
        NSLayoutConstraint.activate([
            handShapeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            handShapeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            handShapeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            handShapeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configureLabel(with handShape: String) {
        handShapeLabel.text = handShape
    }
}
