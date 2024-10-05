//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by  Дмитрий on 03.10.2024.
//

import UIKit


class AlertPresenter {
    private weak var delegate : UIViewController?
    
    func showResultsAlert(model: AlertModel) {
        let alert = UIAlertController(
                    title:  model.title,
                    message: model.message,
                    preferredStyle: .alert)
        let action = UIAlertAction(title:  model.buttonText, style: .default) {  _  in
            model.completion()
        }
        alert.addAction(action)
        delegate?.present(alert, animated: true, completion: nil)
        
    }
}
