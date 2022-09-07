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
    
}

extension ChatTableViewCell: Configurable {
    typealias Model = ChatTableViewCellModel
    
    struct ChatTableViewCellModel {
        let message: String
        let avatarURL: String?
        let messageDate: String?
    }
    
    func configure(with model: Model) {
        
    }
}
