//
//  QuestionListConfigurator.swift
//  Questions
//
//  Created by Сергей Лукичев on 18.10.2023.
//  
//

import UIKit

final class QuestionListConfigurator {
    func configure() -> UIViewController {
        let view = QuestionListViewController()
        let presenter = QuestionListPresenter()
        let router = QuestionListRouter()
        let interactor = QuestionListInteractor(database: DatabaseService())
        
        view.presenter = presenter

        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view

        interactor.presenter = presenter
        
        router.view = view
        
        return view
    }
}
