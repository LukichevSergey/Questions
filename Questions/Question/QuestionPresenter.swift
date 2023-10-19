//
//  QuestionPresenter.swift
//  Questions
//
//  Created by Сергей Лукичев on 19.10.2023.
//  
//

import Foundation

// MARK: Protocol - QuestionViewToPresenterProtocol (View -> Presenter)
protocol QuestionViewToPresenterProtocol: AnyObject {
	func viewDidLoad()
    func saveButtonTapped()
}

// MARK: Protocol - QuestionInteractorToPresenterProtocol (Interactor -> Presenter)
protocol QuestionInteractorToPresenterProtocol: AnyObject {

}

final class QuestionPresenter {

    // MARK: Properties
    var router: QuestionPresenterToRouterProtocol!
    var interactor: QuestionPresenterToInteractorProtocol!
    weak var view: QuestionPresenterToViewProtocol!
}

// MARK: Extension - QuestionViewToPresenterProtocol
extension QuestionPresenter: QuestionViewToPresenterProtocol {
    func viewDidLoad() {
        if let question = interactor.question {
            view.setData(question: question.question, answer: question.answer)
        } else {
            view.setData(question: "", answer: "")
        }
    }
    
    func saveButtonTapped() {
        logger.log("\(#fileID) -> \(#function)")
        
        let data = view.getData()
        interactor.saveQuestion(question: data.question, answer: data.answer)
    }
}

// MARK: Extension - QuestionInteractorToPresenterProtocol
extension QuestionPresenter: QuestionInteractorToPresenterProtocol {
    
}
