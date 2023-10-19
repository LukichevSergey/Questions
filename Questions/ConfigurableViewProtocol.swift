//
//  ConfigurableViewProtocol.swift
//  Questions
//
//  Created by Сергей Лукичев on 19.10.2023.
//

import Foundation

protocol ConfigurableViewProtocol {
    associatedtype ConfigurationModel
    func configure(with model: ConfigurationModel)
}
