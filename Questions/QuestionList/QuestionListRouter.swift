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

}

final class QuestionListRouter {

    // MARK: Properties
    weak var view: QuestionListRouterToViewProtocol!
}

// MARK: Extension - QuestionListPresenterToRouterProtocol
extension QuestionListRouter: QuestionListPresenterToRouterProtocol {
    
}
