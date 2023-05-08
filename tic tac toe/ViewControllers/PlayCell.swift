//
//  PlayCell.swift
//  tic tac toe
//
//  Created by juliemoorled on 05.05.2023.
//

import UIKit

final class PlayCell: UICollectionViewCell {

    // MARK: - Public properties

    static let cellID = "PlayCell"

    // MARK: - Private properties

    private let imageView = UIImageView()
    private let xImage = UIImage(systemName: "xmark")
    private let oImage = UIImage(systemName: "circle")

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods (game)

    func setPlayer(_ player: Player) {
        switch player {
        case .x:
            imageView.image = xImage
        case .o:
            imageView.image = oImage
        }
        animateCell()
    }

    func clear() {
        imageView.image = nil
    }

}

extension PlayCell {

    // MARK: - Private methods (interface setup)

    private func setupCell() {
        backgroundColor = .systemGray6
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6)
        ])
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.tintColor = .systemIndigo
    }

    private func animateCell() {
        imageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.6,
                       options: .curveEaseInOut,
                       animations: { self.imageView.transform = CGAffineTransform.identity },
                       completion: nil)
    }


}
