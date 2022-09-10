//
//  Router.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 07.09.2022.
//

import UIKit

protocol RouterProtocol {
    func pop(animated: Bool)
    func dismiss()
    func openChatScreen()
    func openMessageDetailScreen(with message: MessageViewModel, at index: Int, delegate: MessageDetailViewProtocol)
}

final class Router: RouterProtocol {
    
    // MARK: - Singelton patern
    
    static let shared = Router()
    private init() {}
    
    // MARK: - Properties
    
    let navigationController = UINavigationController()
    
    // MARK: - Pop
    
    func pop(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
    
    // MARK: - Dismiss
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
    
    // MARK: - OpenSplashScreen
    
    func openChatScreen() {
        let chatScreenVC = ChatScreenViewController()
        let presenter = ChatPresenter(view: chatScreenVC, chatService: ChatServiceImp.chatService)
        chatScreenVC.presenter = presenter
        navigationController.viewControllers = [chatScreenVC]
    }
    
    func openMessageDetailScreen(with message: MessageViewModel, at index: Int, delegate: MessageDetailViewProtocol) {
        let messageDetailVC = MessageDetailViewController(index: index, message: message)
        messageDetailVC.delegate = delegate
        navigationController.pushViewController(messageDetailVC, animated: true)
    }
    
}
