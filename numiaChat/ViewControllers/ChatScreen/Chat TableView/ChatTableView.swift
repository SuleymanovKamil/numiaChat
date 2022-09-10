//
//  ChatTableView.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 07.09.2022.
//

import UIKit

protocol ChatTableViewProtocol: AnyObject {
    func requestForNextPage(offset: Int)
    func showMessageDetail(with message: MessageViewModel, at index: Int)
}

final class ChatTableView: UITableView {
    
    // MARK: - Delegate
    
    weak var eventsDelegate: ChatTableViewProtocol?
    
    // MARK: - Properties
    
    var savedMessagesCount = 0
    private var offset: Int {
        return 23 - savedMessagesCount //количество подгружаемых сообщений за один запрос + индекс на котором срабатывает метод пагинации
    }
    private var isLoading = false
    var messages: [MessageViewModel] = [] {
        didSet {
            reloadData()
            
            guard isLoading else {
                return
            }
            
            scrollToRow(at: IndexPath(row: offset, section: 0), at: .top, animated: false)
            isLoading = false
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
        eventsDelegate?.showMessageDetail(with: messages[indexPath.row], at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isLoading == false, numberOfRowsToEndFrom(indexPath: indexPath) + savedMessagesCount < 5 else {
            return
        }
        
        eventsDelegate?.requestForNextPage(offset: messages.count)
        isLoading = true
    }
    
}
