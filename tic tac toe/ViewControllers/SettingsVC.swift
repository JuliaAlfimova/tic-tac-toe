//
//  SettingsVC.swift
//  tic tac toe
//
//  Created by juliemoorled on 06.05.2023.
//

import UIKit

final class SettingsVC: UIViewController {

    // MARK: - Private properties

    private let mainLabel = UILabel()
    private let playersLabel = UILabel()
    private let playersSegmentControl = UISegmentedControl(items: ["1", "2"])
    private let dimensionLabel = UILabel()
    private let dimensionSegmentControl = UISegmentedControl(items: ["3", "5", "7"])
    private let startButton = UIButton()

    private let const: CGFloat = 22
    private let buttonHeight: CGFloat = 100
    private let bigFontSize: CGFloat = 26
    private let smallFontSize: CGFloat = 18

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }

    // MARK: - Actions

    @objc func startButtonTapped(sender: UIButton!) {
        startButton.animateButton()
        let playVC = PlayVC()
        if let selectedDimension = Int(dimensionSegmentControl.titleForSegment(at: dimensionSegmentControl.selectedSegmentIndex) ?? ""),
            let selectedPlayers = Int(playersSegmentControl.titleForSegment(at: playersSegmentControl.selectedSegmentIndex) ?? "") {
            playVC.setConditions(dimension: selectedDimension,
                                 players: selectedPlayers)
        }
        self.navigationController?.pushViewController(playVC, animated: true)
    }

}

extension SettingsVC {

    // MARK: - Private methods (interface setup)

    private func setupInterface() {
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.tintColor = .label

        setupButton(startButton)

        setupSegmentControl(segmentControl: dimensionSegmentControl,
                            selectedIndex: 0,
                            bottomAnchor: startButton.topAnchor)

        setupLabel(label: dimensionLabel,
                   title: "dimension:",
                   font: UIFont.systemFont(ofSize: smallFontSize, weight: .regular),
                   bottomAnchor: dimensionSegmentControl.topAnchor)

        setupSegmentControl(segmentControl: playersSegmentControl,
                            selectedIndex: 1,
                            bottomAnchor: dimensionLabel.topAnchor)

        setupLabel(label: playersLabel,
                   title: "players:",
                   font: UIFont.systemFont(ofSize: smallFontSize, weight: .regular),
                   bottomAnchor: playersSegmentControl.topAnchor)

        setupLabel(label: mainLabel,
                   title: "new game",
                   font: UIFont.systemFont(ofSize: bigFontSize, weight: .semibold),
                   bottomAnchor: playersLabel.topAnchor)

    }

    private func setupLabel(label: UILabel, title: String, font: UIFont, bottomAnchor: NSLayoutYAxisAnchor) {
        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: const),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -const),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -const)
        ])

        label.textColor = .systemIndigo
        label.textAlignment = .center
        label.textColor = .label
        label.font = font
        label.text = title
    }

    private func setupSegmentControl(segmentControl: UISegmentedControl, selectedIndex: Int, bottomAnchor: NSLayoutYAxisAnchor) {
        view.addSubview(segmentControl)

        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            segmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -const)
        ])

        segmentControl.selectedSegmentIndex = selectedIndex
    }

    private func setupButton(_ button: UIButton) {
        view.addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: const),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -const),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: const),
            button.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])

        button.titleLabel?.font = .systemFont(ofSize: bigFontSize, weight: .semibold)
        button.setTitleColor(.systemGray6, for: .normal)
        button.setTitle("start", for: .normal)
        button.layer.cornerRadius = buttonHeight / 2
        button.backgroundColor = .systemIndigo
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }


}
