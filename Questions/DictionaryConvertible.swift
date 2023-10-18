//
//  DictionaryConvertible.swift
//  Questions
//
//  Created by Сергей Лукичев on 18.10.2023.
//

import Foundation

protocol DictionaryConvertible {
    init?(from dictionary: [String: Any])
    var toDict: [String: Any] { get }
}
