//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by  Дмитрий on 03.10.2024.
//

import UIKit


class AlertPresenter {
     weak var delegate: AlertPresenterDelegate?
     weak var viewController: UIViewController?
     init(viewController: UIViewController) {
         self.viewController = viewController
     }
    
    func showResultsAlert(with model: AlertModel?) {
        let alert = UIAlertController(
            title: model?.title,
            message: model?.message,
            preferredStyle: .alert)
                
        let action = UIAlertAction(title: model?.buttonText, style: .default) {[weak self] _ in
            model?.completion?()
            self?.delegate?.restartQuiz()
        }
            alert.addAction(action)
            viewController?.present(alert, animated: true, completion: nil)
        
   }
}
