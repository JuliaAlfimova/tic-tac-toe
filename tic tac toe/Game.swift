//
//  Game.swift
//  tic tac toe
//
//  Created by juliemoorled on 05.05.2023.
//

import Foundation

enum Player {
    case x
    case o
}

struct Move {
    let player: Player
    let position: Int
}

class Game {

    let dimension: Int
    var moves = [Move]()
    var withComputer: Bool = false

    init(dimension: Int) {
        self.dimension = dimension
    }

    func makeMove(_ move: Move) {
        moves.append(move)
    }

    func makeComputerMove() {
        let availablePositions = Array(0..<dimension*dimension).filter({ playerAtPosition($0) == nil })
        if let randomPosition = availablePositions.randomElement() {
            let computerMove = Move(player: .o, position: randomPosition)
            makeMove(computerMove)
        }
    }

    func playerAtPosition(_ position: Int) -> Player? {
        for move in moves {
            if move.position == position {
                return move.player
            }
        }
        return nil
    }

    func winner() -> Player? {

        var lines = [[Int]]() //

        // horizontal lines
        for i in 0..<dimension {
            lines.append(Array(i*dimension..<(i+1)*dimension))
        }

        // vertical lines
        for i in 0..<dimension {
            var line = [Int]()
            for j in 0..<dimension {
                line.append(i+j*dimension)
            }
            lines.append(line)
        }

        // diagonal from left to right
        var line = [Int]()
        for i in 0..<dimension {
            line.append(i*(dimension+1))
        }
        lines.append(line)

        // diagonal from right to left
        line = [Int]()
        for i in 0..<dimension {
            line.append((i+1)*(dimension-1))
        }
        lines.append(line)

        for line in lines {
            let playerAtPosition0 = playerAtPosition(line[0])
            if playerAtPosition0 == nil {
                continue
            }
            var winner = true
            for i in 1..<line.count {
                let playerAtPositionI = playerAtPosition(line[i])
                if playerAtPositionI != playerAtPosition0 {
                    winner = false
                    break
                }
            }
            if winner {
                return playerAtPosition0
            }
        }
        return nil
    }

    func isGameOver() -> Bool {
        if winner() != nil || moves.count == dimension * dimension {
            return true
        }
        return false
    }
    
}
