//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by  Дмитрий on 16.10.2024.
//

import UIKit



class MovieQuizPresenter: QuestionFactoryDelegate{
    private let statisticService: StatisticServiceProtocol!
    private var questionFactory: QuestionFactoryProtocol?
    private weak var viewController: MovieQuizViewControllerProtocol?

    private var currentQuestion: QuizQuestion?
    private let questionsAmount: Int = 10
    private var currentQuestionIndex: Int = 0
    private var correctAnswers: Int = 0
    var alertPresenter: AlertPresenter?
    
    
    init(viewController: MovieQuizViewControllerProtocol) {
        self.viewController = viewController
        
        statisticService = StatisticService()
        questionFactory = QuestionFactory(moviesLoader: MoviesLoader(), delegate: self)
        questionFactory?.loadData()
        viewController.showLoadingIndicator()
        if let viewController = viewController as? UIViewController {
            alertPresenter = AlertPresenter(viewController: viewController)
        }
    }
    
    func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel(
            image: UIImage(data: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
        return questionStep
    }

    func yesButtonClicked() {
        answerGived(answer: true)
    }
    
    func noButtonClicked() {
        answerGived(answer: false)
    }
    
    
    private func answerGived(answer: Bool) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        self.showAnswerResult(isCorrect: answer == currentQuestion.correctAnswer)
    }
    
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }

        currentQuestion = question
        let viewModel = convert(model: question)
        
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.show(quiz: viewModel)
        }
    }
    
    private func proceedToNextQuestionOrResults() {
        if self.isLastQuestion() {
            let currentDate = Date()
            let gameResult = GameResult(correct: correctAnswers,
                                        total: questionsAmount,
                                        date: currentDate)
            statisticService.store(currentGame: gameResult)
            
            let gamesCount = statisticService.gamesCount
            let bestGame = statisticService.bestGame
            let totalAccuracy = statisticService.totalAccuracy * 10
            let bestGameDate = bestGame.date.dateTimeString
            
            let message: [String] = [
                "Ваш результат: \(correctAnswers)",
                "Количество сыгранных квизов: \(gamesCount)",
                "Рекорд: \(bestGame.correct)/10 (\(bestGameDate))",
                "Средняя точность: \("\(String(format: "%.2f", totalAccuracy))%")"]
            let text = message.joined(separator: "\n")
            
            let viewModel = QuizResultsViewModel(
                title: "Этот раунд окончен!",
                text: text,
                buttonText: "Сыграть ещё раз")
            viewController?.show(quiz: viewModel)
        } else {
            currentQuestionIndex += 1
            
            self.questionFactory?.requestNextQuestion()
        }
    }
    
  
    
    func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
            self.correctAnswers += 1
        }
        
        viewController?.noButton.isEnabled = false
        viewController?.yesButton.isEnabled = false
        
        viewController?.imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
                
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            
            viewController?.imageView.layer.borderColor = UIColor.clear.cgColor
            self.proceedToNextQuestionOrResults()
            
            viewController?.noButton.isEnabled = true
            viewController?.yesButton.isEnabled = true
        }
    }
    
    func didLoadDataFromServer() {
        viewController?.hideLoadingIndicator()
        questionFactory?.requestNextQuestion()
    }
    
    func didFailToLoadData(with error: Error) {
        let message = error.localizedDescription
        viewController?.showNetworkError(message: message)
    }
    
    func restartGame() {
        currentQuestionIndex = 0
        correctAnswers = 0
        questionFactory?.requestNextQuestion()
        questionFactory?.loadData()
    }
    
    func isLastQuestion() -> Bool {
        currentQuestionIndex == questionsAmount - 1
    }
    
    func resetQuestionIndex() {
        currentQuestionIndex = 0
    }
    
    func switchToNextQuestion() {
        currentQuestionIndex += 1
    }
}



