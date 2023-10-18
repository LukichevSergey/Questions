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
    func getQuestions() async throws -> [Question] {
        logger.log("\(#fileID) -> \(#function)")
        return try await getCollection(from: questionRef)
    }
}
