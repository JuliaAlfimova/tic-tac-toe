//
//  PlayScoreView.swift
//  tic tac toe
//
//  Created by juliemoorled on 08.05.2023.
//

import UIKit

final class PlayScoreView: UIView {

    // MARK: - Public properties
    
    var xScore: Int = 0
    var oScore: Int = 0

    // MARK: - Private properties
    
    private let xImageView = UIImageView(image: UIImage(systemName: "xmark"))
    private let oImageView = UIImageView(image: UIImage(systemName: "circle"))
    private let xLabel = UILabel()
    private let oLabel = UILabel()

    private let scoreFontSize: CGFloat = 50

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScoreView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods (game score)

    func setScore(xScore: Int, oScore: Int) {
        xLabel.text = " \(xScore) "
        oLabel.text = " \(oScore) "
    }
    
}

extension PlayScoreView {

    // MARK: - Private methods (interface setup)

    private func setupScoreView() {
        setupScoreLabel(xLabel)
        setupScoreLabel(oLabel)
        setupImageView(xImageView)
        setupImageView(oImageView)

        NSLayoutConstraint.activate([
            xLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            xLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            oLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            oLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            xImageView.trailingAnchor.constraint(equalTo: xLabel.leadingAnchor, constant: -8),
            xImageView.centerYAnchor.constraint(equalTo: centerYAnchor),

            oImageView.leadingAnchor.constraint(equalTo: oLabel.trailingAnchor, constant: 8),
            oImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

    }

    private func setupScoreLabel(_ label: UILabel) {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " 0 "
        label.font = .systemFont(ofSize: scoreFontSize, weight: .light)
        label.textColor = .systemGray6
        label.backgroundColor = .systemIndigo.withAlphaComponent(0.8)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = scoreFontSize/5
    }

    private func setupImageView(_ imageView: UIImageView) {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 50, weight: .semibold)
        imageView.preferredSymbolConfiguration = symbolConfiguration
        imageView.tintColor = .systemIndigo
    }


}
