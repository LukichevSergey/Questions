//
//  QuestionListRouter.swift
//  Questions
//
//  Created by Сергей Лукичев on 18.10.2023.
//  
//

import Foundation

// MARK: Protocol - QuestionListPresenterToRouterProtocol (Presenter -> Router)
protocol QuestionListPresenterToRouterProtocol: AnyObject {
    func navigateToQuestion(with question: Question?)
}

final class QuestionListRouter {

    // MARK: Properties
    weak var view: QuestionListRouterToViewProtocol!
}

// MARK: Extension - QuestionListPresenterToRouterProtocol
extension QuestionListRouter: QuestionListPresenterToRouterProtocol {
    func navigateToQuestion(with question: Question?) {
        logger.log("\(#fileID) -> \(#function)")
        
        let viewController = QuestionConfigurator().configure(with: question)
        view.pushView(view: viewController)
    }
}
