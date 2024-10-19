//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by  Дмитрий on 05.10.2024.
//

import Foundation

final class StatisticService {
    private let storage: UserDefaults = .standard

}

extension StatisticService: StatisticServiceProtocol {
    var gamesCount: Int {
        get {
            storage.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            storage.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: GameResult {
        get {
            let correct = storage.integer(forKey: Keys.correct.rawValue)
            let total = storage.integer(forKey: Keys.total.rawValue)
            let date = storage.object(forKey: Keys.date.rawValue) as? Date ?? Date()
            
            return GameResult(correct: correct, total: total, date: date)
        }
        set {
            storage.set(newValue.correct, forKey: Keys.correct.rawValue)
            storage.set(newValue.total, forKey: Keys.total.rawValue)
            storage.set(newValue.date, forKey: Keys.date.rawValue)
        }
    }
    
    var totalAccuracy: Double {
        get {
            storage.double(forKey: Keys.accurancy.rawValue)
        }
        set {
            storage.setValue(newValue, forKey: Keys.accurancy.rawValue)
        }
    }
    
    func store(currentGame: GameResult) {
        totalAccuracy = (totalAccuracy * Double(gamesCount) + Double(currentGame.correct)) / Double(gamesCount + 1)
        gamesCount = gamesCount + 1
        if bestGame.isBetter(gameResult: currentGame) {
            bestGame = currentGame
        }
    }
    
    private enum Keys: String {
        case correct
        case gamesCount
        case total
        case date
        case accurancy
    }
}
