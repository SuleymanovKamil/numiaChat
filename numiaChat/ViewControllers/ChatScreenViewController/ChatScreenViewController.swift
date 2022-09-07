//
//  ChatScreenViewController.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 07.09.2022.
//

import UIKit

protocol ChatScreen: AnyObject {
    func updateView(_ messages: [String]) async
}

class ChatScreenViewController: UIViewController {
    
    // MARK: - Controller
    
    var controller: ChatScreenProtocol?
    
    // MARK: - Views
    
    private lazy var screenTitle: UILabel = {
        let label = UILabel()
        label.text = "Тестовое задание"
        label.font = .systemFont(ofSize: 26, weight: .black)
        return label
    }()
    private lazy var chatTableView: ChatTableView = {
        let tableView = ChatTableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        Task {
            await controller?.fetchMessages(offset: 0)
        }
    }

    private func setupConstraints() {
        view.addSubview(screenTitle)
        screenTitle.translatesAutoresizingMaskIntoConstraints = false
        screenTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        screenTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        
        view.addSubview(chatTableView)
        chatTableView.translatesAutoresizingMaskIntoConstraints = false
        chatTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        chatTableView.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 0).isActive = true
        chatTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        chatTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }

}

extension ChatScreenViewController: ChatScreen {
    func updateView(_ messages: [String]) {
        chatTableView.messages = messages
    }
    
}
