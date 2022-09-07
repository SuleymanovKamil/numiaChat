//
//  ChatTableViewCell.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 07.09.2022.
//

import UIKit

final class ChatTableViewCell: UITableViewCell  {
    
    //MARK: - Identifier
    
    class var identifier: String {
        return "ChatTableViewCell"
    }
    
    //MARK: - Properties
    
    private lazy var message: UILabel = {
        let label = UILabel()
        return label
    }()
    
    //MARK: - Lifecycle
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupConstraints()
    }
    
    //MARK: - Setups
   
    private func setupConstraints() {
        contentView.addSubview(message)
        message.translatesAutoresizingMaskIntoConstraints = false
        message.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        message.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        message.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        message.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8).isActive = true
    }
    
}

extension ChatTableViewCell: Configurable {
    typealias Model = ChatTableViewCellModel
    
    struct ChatTableViewCellModel {
        let message: String
        let avatarURL: String?
        let messageDate: String?
    }
    
    func configure(with model: Model) {
        message.text = model.message
    }
    
}
