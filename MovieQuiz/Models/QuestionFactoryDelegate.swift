//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by  Дмитрий on 02.10.2024.
//

import Foundation


protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
}
