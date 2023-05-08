//
//  PlayVC.swift
//  tic tac toe
//
//  Created by juliemoorled on 05.05.2023.
//

import UIKit

final class PlayVC: UIViewController {

    // MARK: - Public properties

    var dimension = 3
    var players = 2
    var game = Game(dimension: 3)
    var withComputer = false
    var freeIndices = [Bool](repeating: true, count: 9)

    // MARK: - Private properties

    private let collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: UICollectionViewFlowLayout())
    private let scoreView = PlayScoreView()
    private let statusLabel = UILabel()
    private let newRoundButton = UIButton()
    private let newStartButton = UIButton()
    private let const: CGFloat = 16
    private let labelFontSize: CGFloat = 26
    private let buttonHeight:CGFloat = 50
    private var xScore: Int = 0
    private var oScore: Int = 0

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }

    // MARK: - Actions

    @objc private func refreshAction() {
        startNewGame(dimension: dimension)
        collectionView.reloadData()
    }

    // MARK: - Methods (game)

    func setConditions(dimension: Int, players: Int) {
        self.dimension = dimension
        self.players = players
        if players == 1 {
            withComputer = true
        }
        startNewGame(dimension: dimension)
    }

    func startNewGame(dimension: Int) {
        self.game = Game(dimension: dimension)
        self.freeIndices = [Bool](repeating: true, count: dimension*dimension)
        statusLabel.text = "player x turn"
    }

    func makeMove(at indexPath: IndexPath) {
        let player = game.moves.count % 2 == 0 ? Player.x : Player.o
        let move = Move(player: player, position: indexPath.item)
        game.makeMove(move)
        collectionView.reloadData()
        freeIndices[indexPath.row] = false
        let nextPlayer = player == .x ? Player.o : Player.x
        statusLabel.text = "player \(nextPlayer) turn"
        checkForWin()
    }

    func makeComputerMove() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.game.makeComputerMove()
            self.collectionView.reloadData()
            self.statusLabel.text = "player x turn"
            self.checkForWin()
        }
    }

    func checkForWin() {
        if let winner = game.winner() {
            showWinAlertController(winText: "player \(winner) wins!")
            if winner == .x {
                xScore += 1
            } else {
                oScore += 1
            }
            scoreView.setScore(xScore: xScore, oScore: oScore)
            //салютик
        } else if game.isGameOver() {
            showWinAlertController(winText: "it's a tie!")
        }
    }

}

extension PlayVC {

    // MARK: - Private methods (interface setup)

    private func setupInterface() {
        view.backgroundColor = .systemGray6
        navigationController?.navigationBar.tintColor = .systemIndigo
        let refreshButton = UIBarButtonItem(image: UIImage(systemName: "gobackward"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(refreshAction))
        navigationItem.rightBarButtonItem = refreshButton
        setupScoreView()
        setupCollectionView()
        setupStatusLabel()
    }

    private func setupScoreView() {
        view.addSubview(scoreView)
        scoreView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            scoreView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: const),
            scoreView.heightAnchor.constraint(equalToConstant: buttonHeight),
            scoreView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.99),
            collectionView.topAnchor.constraint(equalTo: scoreView.bottomAnchor, constant: const),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PlayCell.self,
                                forCellWithReuseIdentifier: PlayCell.cellID)
        collectionView.backgroundColor = .systemIndigo
        collectionView.isScrollEnabled = false
        collectionView.layer.borderColor = UIColor.systemIndigo.cgColor
        collectionView.layer.borderWidth = 1.0
        collectionView.layer.masksToBounds = true
        collectionView.layer.cornerRadius = 10
    }

    private func setupStatusLabel() {
        view.addSubview(statusLabel)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: const),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -const),
            statusLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: const)
        ])
        statusLabel.font = .systemFont(ofSize: labelFontSize, weight: .semibold)
        statusLabel.textAlignment = .center
        statusLabel.textColor = .systemIndigo
    }

    func showWinAlertController(winText: String?) {
        let alert = UIAlertController(title: winText,
                                      message: "start a new round?",
                                      preferredStyle: .alert)
        let startAction = UIAlertAction(title: "start", style: .default) { _ in
            self.startNewGame(dimension: self.dimension)
            self.collectionView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(startAction)
        alert.addAction(cancelAction)
        if alert.isBeingPresented { return }
        present(alert, animated: true)
    }

}
