//
//  QuestionListInteractor.swift
//  Questions
//
//  Created by Сергей Лукичев on 18.10.2023.
//  
//

import Foundation
import OSLog

// MARK: Protocol - QuestionListPresenterToInteractorProtocol (Presenter -> Interactor)
protocol QuestionListPresenterToInteractorProtocol: AnyObject {
    var questions: [Question] { get }
    
    func fetchQuestions()
}

final class QuestionListInteractor {
    
    private let database: QuestionsToDatabaseServiceProtocol
    private var _questions: [Question]

    // MARK: Properties
    weak var presenter: QuestionListInteractorToPresenterProtocol!

    init(database: QuestionsToDatabaseServiceProtocol) {
        self.database = database
        self._questions = []
    }
}

// MARK: Extension - QuestionListPresenterToInteractorProtocol
extension QuestionListInteractor: QuestionListPresenterToInteractorProtocol {
    
    var questions: [Question] {
        return _questions
    }
    
    @MainActor
    func fetchQuestions() {
        logger.log("\(#fileID) -> \(#function)")
        
        Task {
            do {
                _questions = try await database.getQuestions()
                presenter.questionsIsFetched()
            }
        }
    }
}
