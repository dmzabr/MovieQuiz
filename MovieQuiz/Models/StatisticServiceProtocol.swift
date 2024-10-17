//
//  StatisticServiceProtocol.swift
//  MovieQuiz
//
//  Created by  Дмитрий on 05.10.2024.
//
import Foundation

protocol StatisticServiceProtocol {
    var gamesCount: Int {get}
    var bestGame: GameResult {get}
    var totalAccuracy: Double {get}
    
    func store (currentGame: GameResult)
}


