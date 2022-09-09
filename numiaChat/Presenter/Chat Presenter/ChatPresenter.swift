//
//  ChatPresenter.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 07.09.2022.
//

import UIKit

protocol ChatScreenProtocol: AnyObject {
    func fetchMessages(offset: Int) async
    func fetchSavedMessages() async -> [MessageViewModel]
    func showMessageDetailScreen(_ message: MessageViewModel, at index: Int)
}

final class ChatPresenter {
    
    //MARK: - Properties
    
    let router = Router.shared
    let chatService: ChatService
    let view: ChatScreen
    var messages: [String] = []
    
    //MARK: - Init
    
    init(view: ChatScreen, chatService: ChatService) {
        self.view = view
        self.chatService = chatService
    }
    
}

extension ChatPresenter: ChatScreenProtocol {
    @MainActor func fetchMessages(offset: Int) async {
        view.showLoading()
        let result = await chatService.fetchMessages(offset: offset)
        switch result {
        case .success(let data):
            messages.insert(contentsOf: data.result.reversed(), at: 0)
            await view.updateView(messages)
            view.hideLoading()
        case .failure(let error):
            view.hideLoading()
            view.showInternetRequestErrorView(with: ErrorView.ErrorViewModel(errorMessage: error.localizedDescription, doneButtonTitle: "Подтвердить", cancelButtonTitle: "Отмена", doneButtonAction: { [weak self] in
                Task {
                    await self?.fetchMessages(offset: offset)
                }
            }))
            print(#function, error.localizedDescription)
        }
        
    }
    
    func fetchSavedMessages() async -> [MessageViewModel] {
        guard CoreDataService.shared.fetchData().isEmpty == false else {
            return []
        }
   
        return CoreDataService.shared.fetchData().map({MessageViewModel(image: $0.value(forKeyPath: "avatar") as? String, incoming: false, message: $0.value(forKeyPath: "message") as! String, date: $0.value(forKeyPath: "date") as! String) })
    }
    
    func showMessageDetailScreen(_ message: MessageViewModel, at index: Int) {
        router.openMessageDetailScreen(with: message, at: index, delegate: view)
    }
    
}

