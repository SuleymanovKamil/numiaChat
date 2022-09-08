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
    
    var leadingOrTrailingConstraint = NSLayoutConstraint()
    private lazy var messageView: ChatBubbleView = {
        let view = ChatBubbleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Lifecycle
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupInterface()
    }
    
    //MARK: - Setups
    
    private func setupInterface() {
        contentView.backgroundColor = .systemBackground
    }
   
    private func setData(_ message: MessageViewModel) {
        messageView.messageLabel.text = message.message
        messageView.isIncoming = message.incoming
        messageView.timeLabel.text = message.date
        
        leadingOrTrailingConstraint.isActive = false
        contentView.addSubview(messageView)
        messageView.translatesAutoresizingMaskIntoConstraints = false
        messageView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.66).isActive = true
        messageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0).isActive = true
        messageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.0).isActive = true
        
        switch message.incoming {
        case true:
            leadingOrTrailingConstraint = messageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0)
        case false:
            leadingOrTrailingConstraint = messageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12.0)
        }
        leadingOrTrailingConstraint.isActive = true
    }
    
}

extension ChatTableViewCell: Configurable {
    typealias Model = ChatTableViewCellModel
    
    struct ChatTableViewCellModel {
        let message: String
        let avatarURL: String
        let messageDate: String
    }
    
    func configure(with model: Model) {
        setData(MessageViewModel(incoming: true, message: model.message, date: model.messageDate))
    }
    
}

