//
//  Question.swift
//  Questions
//
//  Created by Сергей Лукичев on 18.10.2023.
//

import Foundation
import FirebaseFirestore

struct Question: Hashable {
    let question: String
    let answer: String
    let views: Int
}

extension Question: DictionaryConvertible {
    init?(from dictionary: [String : Any]) {
        logger.log("\(#fileID) -> \(#function)")
        
        guard let question = dictionary["question"] as? String,
              let answer = dictionary["answer"] as? String,
              let views = dictionary["views"] as? Int else {
            return nil
        }
        
        self.question = question
        self.answer = answer
        self.views = views
    }
    
    init?(from document: QueryDocumentSnapshot) {
        self.init(from: document.data())
    }
    
    var toDict: [String : Any] {
        logger.log("\(#fileID) -> \(#function)")
        
        var dict:[String: Any] = [:]
        
        dict["question"] = question
        dict["answer"] = answer
        dict["views"] = views
        
        return dict
    }
}
