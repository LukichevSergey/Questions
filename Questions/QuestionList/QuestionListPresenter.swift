//
//  QuestionListPresenter.swift
//  Questions
//
//  Created by Сергей Лукичев on 18.10.2023.
//  
//

import Foundation

// MARK: Protocol - QuestionListViewToPresenterProtocol (View -> Presenter)
protocol QuestionListViewToPresenterProtocol: AnyObject {
	func viewDidLoad()
    func tableViewCellTapped(with question: Question)
    func addButtonTapped()
}

// MARK: Protocol - QuestionListInteractorToPresenterProtocol (Interactor -> Presenter)
protocol QuestionListInteractorToPresenterProtocol: AnyObject {
    func questionsIsFetched()
}

final class QuestionListPresenter {

    // MARK: Properties
    var router: QuestionListPresenterToRouterProtocol!
    var interactor: QuestionListPresenterToInteractorProtocol!
    weak var view: QuestionListPresenterToViewProtocol!
}

// MARK: Extension - QuestionListViewToPresenterProtocol
extension QuestionListPresenter: QuestionListViewToPresenterProtocol {
    func viewDidLoad() {
        logger.log("\(#fileID) -> \(#function)")
        
        interactor.fetchQuestions()
    }
    
    func tableViewCellTapped(with question: Question) {
        logger.log("\(#fileID) -> \(#function)")
        
        interactor.updateViewForQuestion(question: question)
        router.navigateToQuestion(with: question)
    }
    
    func addButtonTapped() {
        logger.log("\(#fileID) -> \(#function)")
        
        router.navigateToQuestion(with: nil)
    }
}

// MARK: Extension - QuestionListInteractorToPresenterProtocol
extension QuestionListPresenter: QuestionListInteractorToPresenterProtocol {
    func questionsIsFetched() {
        logger.log("\(#fileID) -> \(#function)")
        
        view?.setData(interactor.questions)
    }
}
