//
//  ChatTableView.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 07.09.2022.
//

import UIKit

protocol ChatTableViewProtocol: AnyObject {
    func requestForNextPage(offset: Int)
    func showMessageDetail(with message: MessageViewModel)
}

final class ChatTableView: UITableView {
    
    // MARK: - Delegate
    
    weak var eventsDelegate: ChatTableViewProtocol?
  
    // MARK: - Properties
    
    var messagesCount = 0
    var messages: [MessageViewModel] = [] {
        didSet {
            reloadData()
        }
    }

    // MARK: - Lifecycle
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupInterface()
        setupDelegate()
        registerTableViewCell()
    }
    
    // MARK: - Setups
    
    private func setupDelegate() {
        delegate = self
        dataSource = self
    }
    
    private func registerTableViewCell() {
        register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.identifier)
    }
    
    private func setupInterface() {
        separatorStyle = .none
        showsVerticalScrollIndicator = true
        backgroundColor = .systemBackground
    }
   
}
extension ChatTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as! ChatTableViewCell
        cell.configure(with: ChatTableViewCell.Model(message: messages[indexPath.row]))
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventsDelegate?.showMessageDetail(with: messages[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == 10 else {
            return
        }
        
        messagesCount = totalRowsCount
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard messagesCount == totalRowsCount, numberOfRowsToEndFrom(indexPath: indexPath) < 5 else {
            return
        }
        
        eventsDelegate?.requestForNextPage(offset: messages.count)
    }

}
