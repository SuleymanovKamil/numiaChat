//
//  MessageDetailViewController.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 09.09.2022.
//

import UIKit

protocol MessageDetailViewProtocol: AnyObject {
    func deleteMessage(withID: String)
}

final class MessageDetailViewController: UIViewController {
    
    //MARK: - Delegate
    
    weak var delegate: MessageDetailViewProtocol?
  
    //MARK: - Views
    
    
    
    //MARK: - Properties
    
    var message: MessageViewModel?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        setupConstraints()
    }
    
    //MARK: - Setups
    
    private func setupInterface() {
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .red
    }
    
    private func setupConstraints() {
        
    }
    
    //MARK: - Actions
    
    private func deleteButtonAction () {
        guard let message = message else {
            return
        }

        delegate?.deleteMessage(withID: message.id)
    }
    
}
