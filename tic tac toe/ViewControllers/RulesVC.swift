//
//  RulesVC.swift
//  tic tac toe
//
//  Created by juliemoorled on 07.05.2023.
//

import UIKit

final class RulesVC: UIViewController {
    
    // MARK: - Private properties

    private let scrollView = UIScrollView()
    private let rulesLabel = UILabel()
    private let rulesImageView = UIImageView(image: UIImage(named: "Rules"))

    private let const: CGFloat = 32
    private let labelFontSize: CGFloat = 17

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }

}

extension RulesVC {

    // MARK: - Private methods (interface setup)

    private func setupInterface() {
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.tintColor = .label
        setupRulesLabel()
        setupRulesImageView()
    }

    private func setupRulesLabel() {
        view.addSubview(rulesLabel)
        rulesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rulesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: const),
            rulesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -const),
            rulesLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        rulesLabel.font = .systemFont(ofSize: labelFontSize, weight: .regular)
        rulesLabel.textAlignment = .center
        rulesLabel.textColor = .label
        rulesLabel.numberOfLines = 0
        rulesLabel.text = "tic tac toe is played on a 3x3, 5x5 or 7x7 grid. players take turns placing their symbol on an empty space on the board until a winner is determined or the game ends in a draw. \n\n the first player to get three of their symbols in a row (horizontally, vertically, or diagonally) wins the game. \n if all nine spaces on the board are filled and neither player has won, the game is a draw. "
    }

    private func setupRulesImageView() {
        view.addSubview(rulesImageView)
        rulesImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rulesImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.2),
            rulesImageView.heightAnchor.constraint(equalTo: rulesImageView.widthAnchor),
            rulesImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rulesImageView.topAnchor.constraint(equalTo: rulesLabel.bottomAnchor, constant: -const*2)
        ])
    }

}
