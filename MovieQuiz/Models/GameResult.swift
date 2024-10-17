//
//  GameResult.swift
//  MovieQuiz
//
//  Created by  Дмитрий on 05.10.2024.
//

import Foundation

struct GameResult {
    let correct: Int
    let total: Int
    let date: Date
    
    func isBetter(gameResult: GameResult) -> Bool {
        return gameResult.correct > correct
    }
}
