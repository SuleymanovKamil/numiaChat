//
//  Configurable.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 07.09.2022.
//

import Foundation

protocol Configurable {
    associatedtype Model
    func configure(with model: Model)
}
