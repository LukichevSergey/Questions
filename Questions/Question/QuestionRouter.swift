//
//  QuestionRouter.swift
//  Questions
//
//  Created by Сергей Лукичев on 19.10.2023.
//  
//

import Foundation

// MARK: Protocol - QuestionPresenterToRouterProtocol (Presenter -> Router)
protocol QuestionPresenterToRouterProtocol: AnyObject {

}

final class QuestionRouter {

    // MARK: Properties
    weak var view: QuestionRouterToViewProtocol!
}

// MARK: Extension - QuestionPresenterToRouterProtocol
extension QuestionRouter: QuestionPresenterToRouterProtocol {
    
}
