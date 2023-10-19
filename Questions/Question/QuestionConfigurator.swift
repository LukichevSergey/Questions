//
//  QuestionConfigurator.swift
//  Questions
//
//  Created by Сергей Лукичев on 19.10.2023.
//  
//

import UIKit

final class QuestionConfigurator {
    func configure(with question: Question?) -> UIViewController {
        let view = QuestionViewController()
        let presenter = QuestionPresenter()
        let router = QuestionRouter()
        let interactor = QuestionInteractor(question: question, database: DatabaseService())
        
        view.presenter = presenter

        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view

        interactor.presenter = presenter
        
        router.view = view
        
        return view
    }
}
