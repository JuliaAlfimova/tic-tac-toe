//
//  PlayCollectionView.swift
//  tic tac toe
//
//  Created by juliemoorled on 07.05.2023.
//

import UIKit

extension PlayVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // MARK: - CollectionView methods (game grid)

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size.width / CGFloat(dimension) - 1
        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dimension*dimension
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayCell.cellID,
                                                      for: indexPath) as? PlayCell
        if let player = game.playerAtPosition(indexPath.item) {
            cell?.setPlayer(player)
        } else {
            cell?.clear()
        }
        return cell ?? .init()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !freeIndices[indexPath.row] { return } 
        makeMove(at: indexPath)
        if withComputer && !game.isGameOver() {
            makeComputerMove()
        }
    }
}
