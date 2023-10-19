//
//  DataBaseService.swift
//  Questions
//
//  Created by Сергей Лукичев on 18.10.2023.
//

import Foundation
import FirebaseFirestore

protocol QuestionsToDatabaseServiceProtocol {
    func getQuestions() async throws -> [Question]
    func updateQuestion(id: String, question: String, answer: String) async throws
    func updateViewForQuestion(with id: String) async throws
    func createNewQuestion(question: String, answer: String) async throws
}

final class DatabaseService {
    private let db = Firestore.firestore()
    
    private var questionRef: CollectionReference {
        return db.collection("question")
    }
}

private extension DatabaseService {
    func getCollection<T: DictionaryConvertible>(from ref: CollectionReference) async throws -> [T] {
        logger.log("\(#fileID) -> \(#function)")
        let snapshot = try await ref.getDocuments()
        let data = snapshot.documents.reduce(into: [[String: Any]]()) { partialResult, querySnapShot in
            partialResult.append(querySnapShot.data())
        }
        return .init(data.compactMap({ T(from: $0) }))
    }
}

extension DatabaseService: QuestionsToDatabaseServiceProtocol {
    func createNewQuestion(question: String, answer: String) async throws {
        logger.log("\(#fileID) -> \(#function)")
        
        let id = UUID().uuidString
        try await questionRef.document(id).setData(Question(id: id, question: question, answer: answer, views: 0).toDict)
    }
    
    func updateQuestion(id: String, question: String, answer: String) async throws {
        logger.log("\(#fileID) -> \(#function)")
        
        let querySnapshot = try await questionRef.document(id).getDocument()
        
        let batch = db.batch()
        
        if var data = querySnapshot.data() {
            data["question"] = question
            data["answer"] = answer
            batch.updateData(data, forDocument: questionRef.document(querySnapshot.documentID))
        }
        
        try await batch.commit()
    }
    
    func updateViewForQuestion(with id: String) async throws {
        logger.log("\(#fileID) -> \(#function)")
        
        let querySnapshot = try await questionRef.document(id).getDocument()
        
        let batch = db.batch()
        
        if var data = querySnapshot.data(), var views = data["views"] as? Int {
            views += 1
            data["views"] = views
            batch.updateData(data, forDocument: questionRef.document(querySnapshot.documentID))
        }
        
        try await batch.commit()
    }
    
    func getQuestions() async throws -> [Question] {
        logger.log("\(#fileID) -> \(#function)")
        return try await getCollection(from: questionRef)
    }
}
