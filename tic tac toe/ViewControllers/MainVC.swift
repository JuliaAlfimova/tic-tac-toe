//
//  ViewController.swift
//  tic tac toe
//
//  Created by juliemoorled on 05.05.2023.
//

import UIKit

final class MainVC: UIViewController {

    // MARK: - Private properties

    private let welcomeLabel = UILabel()
    private let playButton = UIButton()
    private let rulesButton = UIButton()
    private let logoImageView = UIImageView(image: UIImage(named: "LogoTransparent"))

    private let const: CGFloat = 16
    private let buttonHeight: CGFloat = 100
    private let buttonFontSize: CGFloat = 32
    private let labelFontSize: CGFloat = 26

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }

    // MARK: - Actions

    @objc func playButtonTapped(sender: UIButton!) {
        playButton.animateButton()
        let settingsVC = SettingsVC()
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }

    @objc func rulesButtonTapped(sender: UIButton!) {
        rulesButton.animateButton()
        let rulesVC = RulesVC()
        self.navigationController?.pushViewController(rulesVC, animated: true)
    }

}

extension MainVC {

    // MARK: - Private methods (interface setup)

    private func setupInterface() {
        view.backgroundColor = .systemGray6
        setupButton(button: playButton,
                    title: "play",
                    backgroundColor: .systemIndigo,
                    topAnchor: view.centerYAnchor)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        setupButton(button: rulesButton,
                    title: "rules",
                    backgroundColor: .systemIndigo.withAlphaComponent(0.7),
                    topAnchor: playButton.bottomAnchor)
        rulesButton.addTarget(self, action: #selector(rulesButtonTapped), for: .touchUpInside)
        setupLabel(welcomeLabel)
        setupImageView(logoImageView)
    }

    private func setupButton(button: UIButton, title: String, backgroundColor: UIColor, topAnchor: NSLayoutYAxisAnchor) {
        view.addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: const),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -const),
            button.topAnchor.constraint(equalTo: topAnchor, constant: const),
            button.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])

        button.titleLabel?.font = .systemFont(ofSize: buttonFontSize, weight: .bold)
        button.setTitleColor(.systemGray6, for: .normal)
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = buttonHeight / 2
        button.backgroundColor = backgroundColor
        button.layer.masksToBounds = true
    }

    private func setupLabel(_ label: UILabel) {
        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: const),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -const),
            label.bottomAnchor.constraint(equalTo: playButton.topAnchor, constant: -const*2)
        ])

        label.font = .systemFont(ofSize: labelFontSize, weight: .bold)
        label.textColor = .systemIndigo
        label.textAlignment = .center
        label.text = "tic tac toe"
    }

    private func setupImageView(_ imageView: UIImageView) {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.bottomAnchor.constraint(equalTo: welcomeLabel.topAnchor, constant: const*2)
        ])
    }

}

