//
//  File.swift
//  MovieQuiz
//
//  Created by  Дмитрий on 06.09.2024.
//

import Foundation
import UIKit

// для состояния "Вопрос показан"
struct QuizStepViewModel {
  let image: UIImage
  let question: String
  let questionNumber: String
}

// для состояния "Результат квиза"
struct QuizResultsViewModel {
  let title: String
  let text: String
  let buttonText: String
}

struct QuizQuestion {
    let image: String
    let text: String
    let correctAnswer: Bool
}
