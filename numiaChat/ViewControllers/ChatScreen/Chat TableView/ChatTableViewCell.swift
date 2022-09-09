//
//  ChatTableViewCell.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 07.09.2022.
//

import UIKit

final class ChatTableViewCell: UITableViewCell  {
    
    //MARK: - Views
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private lazy var messageView: ChatBubbleView = {
        let view = ChatBubbleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Identifier
    
    class var identifier: String {
        return "ChatTableViewCell"
    }
    
    //MARK: - Properties
    
    var messageViewLeadingOrTrailingConstraint = NSLayoutConstraint()
    var avatarImageViewLeadingOrTrailingConstraint = NSLayoutConstraint()
    
    //MARK: - Lifecycle
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupInterface()
    }
    
    //MARK: - Setups
    
    private func setupInterface() {
        contentView.backgroundColor = .systemBackground
    }
    
    private func setupCell(with message: MessageViewModel) {
        messageView.messageLabel.text = message.message
        messageView.isIncoming = message.incoming
        messageView.timeLabel.text = message.date
        
        messageViewLeadingOrTrailingConstraint.isActive = false
        avatarImageViewLeadingOrTrailingConstraint.isActive = false
        contentView.addSubview(avatarImageView)
        contentView.addSubview(messageView)
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        messageView.translatesAutoresizingMaskIntoConstraints = false
        messageView.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.64).isActive = true
        messageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        messageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        
        switch message.incoming {
        case true:
            messageViewLeadingOrTrailingConstraint = messageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 42)
            avatarImageViewLeadingOrTrailingConstraint = avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        case false:
            messageViewLeadingOrTrailingConstraint = messageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -122)
            avatarImageViewLeadingOrTrailingConstraint = avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        }
        
        messageViewLeadingOrTrailingConstraint.isActive = true
        avatarImageViewLeadingOrTrailingConstraint.isActive = true
        
        guard let image = message.image else {
            return
        }
        
        //Здесь должна быть загрузка изображения из интернета с кэшированием ее, но в рамках задания нельзя использовать сторонние библиотеки, а поднимать свой кэш слишком долго
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 40)
        avatarImageView.image = UIImage(systemName: image, withConfiguration: configuration)
        avatarImageView.tintColor = message.incoming ? .placeholderText : .tertiaryLabel
    }
    
}

extension ChatTableViewCell: Configurable {
    typealias Model = ChatTableViewCellModel
    
    struct ChatTableViewCellModel {
        let message: MessageViewModel
    }
    
    func configure(with model: Model) {
        setupCell(with: model.message)
    }
    
}

