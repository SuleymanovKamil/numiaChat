//
//  MessageViewModel.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 07.09.2022.
//

import Foundation

struct MessageViewModel {
    let id = UUID().uuidString
    let image: String?
    let incoming: Bool
    let message: String
    let date: String
}
