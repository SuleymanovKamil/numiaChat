//
//  ChatTableView.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 07.09.2022.
//

import UIKit

protocol ChatTableViewProtocol: AnyObject {
    func showMessageDetail()
    func refreshData() 
}

final class ChatTableView: UITableView {
    
    // MARK: - Delegate
    
    weak var chatTableViewDelegate: ChatTableViewProtocol?
     
     // MARK: - Views
     
     private lazy var customRefreshControl: UIRefreshControl = {
         let refreshControl = UIRefreshControl()
         refreshControl.tintColor = .brown
         refreshControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
         return refreshControl
     }()
    
    
    // MARK: - Properties
    
    var messages: [String]? {
        didSet {
            reloadData()
            scrollToBottom()
        }
    }

    // MARK: - Lifecycle
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupInterface()
        setupDelegate()
        registerTableViewCell()
        setupRefreshControl()
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
        keyboardDismissMode = .onDrag
        showsVerticalScrollIndicator = true
        backgroundColor = .systemBackground
    }
    
    private func setupRefreshControl() {
        addSubview(customRefreshControl)
    }
    
    // MARK: - RefreshControl action
    
    @objc private func refreshControlAction() {
        chatTableViewDelegate?.refreshData()
        customRefreshControl.endRefreshing()
    }
}
extension ChatTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as! ChatTableViewCell
        if let message = messages?[indexPath.row] {
            cell.configure(with: ChatTableViewCell.Model(message: message, avatarURL: "", messageDate: Date().toString(time: .medium)))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
    }
    
}
