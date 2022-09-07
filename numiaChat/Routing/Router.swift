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
        navigationController.navigationBar.isHidden = true
        navigationController.viewControllers = [chatScreenVC]
    }

}
