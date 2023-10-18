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
    func fetchQuestions()
}

final class QuestionListInteractor {
    
    let database: QuestionsToDatabaseServiceProtocol

    // MARK: Properties
    weak var presenter: QuestionListInteractorToPresenterProtocol!

    init(database: QuestionsToDatabaseServiceProtocol) {
        self.database = database
    }
}

// MARK: Extension - QuestionListPresenterToInteractorProtocol
extension QuestionListInteractor: QuestionListPresenterToInteractorProtocol {
    
    @MainActor
    func fetchQuestions() {
        logger.log("\(#fileID) -> \(#function)")
        
        Task {
            do {
                let questions = try await database.getQuestions()
                print(questions)
            }
        }
    }
}
