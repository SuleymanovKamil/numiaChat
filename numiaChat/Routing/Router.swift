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
    func openMessageDetailScreen(with message: MessageViewModel)
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
    
    func openMessageDetailScreen(with message: MessageViewModel) {
        let messageDetailVC = MessageDetailViewController()
        messageDetailVC.message = message
        navigationController.pushViewController(messageDetailVC, animated: true)
    }

}
