//
//  QuestionInteractor.swift
//  Questions
//
//  Created by Сергей Лукичев on 19.10.2023.
//  
//

import Foundation

// MARK: Protocol - QuestionPresenterToInteractorProtocol (Presenter -> Interactor)
protocol QuestionPresenterToInteractorProtocol: AnyObject {
    var question: Question? { get }
    
    func saveQuestion(question: String, answer: String)
}

final class QuestionInteractor {

    // MARK: Properties
    weak var presenter: QuestionInteractorToPresenterProtocol!
    private let database: QuestionsToDatabaseServiceProtocol
    
    private let _question: Question?
    
    init(question: Question?, database: QuestionsToDatabaseServiceProtocol) {
        _question = question
        self.database = database
    }
}

// MARK: Extension - QuestionPresenterToInteractorProtocol
extension QuestionInteractor: QuestionPresenterToInteractorProtocol {
    var question: Question? {
        return _question
    }
    
    @MainActor
    func saveQuestion(question: String, answer: String) {
        logger.log("\(#fileID) -> \(#function)")
        
        Task {
            do {
                if let _question {
                    try await database.updateQuestion(id: _question.id, question: question, answer: answer)
                } else {
                    try await database.createNewQuestion(question: question, answer: answer)
                }
            } catch {
                
            }
        }
    }
}
