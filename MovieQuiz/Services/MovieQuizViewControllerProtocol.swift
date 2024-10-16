//
//  MovieQuizViewControllerProtocol.swift
//  MovieQuiz
//
//  Created by  Дмитрий on 16.10.2024.
//

import Foundation
import UIKit


protocol MovieQuizViewControllerProtocol: AnyObject {
    var noButton: UIButton! { get }
    var yesButton: UIButton! { get }
    var imageView: UIImageView! { get }
    
    func show(quiz step: QuizStepViewModel)
    func show(quiz result: QuizResultsViewModel)
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func showNetworkError(message: String)
}
