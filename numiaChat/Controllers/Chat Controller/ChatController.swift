//
//  ChatController.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 07.09.2022.
//

import UIKit

protocol ChatScreenProtocol: AnyObject {
    func fetchMessages(offset: Int) async
}

final class ChatController {
    
    //MARK: - Properties
    
    let chatService: ChatService
    let view: ChatScreen
    
    //MARK: - Init
    
    init(view: ChatScreen, chatService: ChatService) {
        self.view = view
        self.chatService = chatService
    }
    
}

extension ChatController: ChatScreenProtocol {
    @MainActor func fetchMessages(offset: Int) async {
        let result = await chatService.fetchMessages(offset: offset)
        switch result {
        case .success(let data):
            await view.updateView(data.result)
        case .failure(let error):
            print(#function, error.localizedDescription)
        }
        
    }
    
}

