//
//  ChatScreenViewController.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 07.09.2022.
//

import UIKit

protocol ChatScreen: EmptyStateProtocol, Loadable, MessageDetailViewProtocol {
    func updateView(_ messages: [String]) async
}

class ChatScreenViewController: UIViewController {
    
    // MARK: - Presenter
    
    var presenter: ChatScreenProtocol?
    
    // MARK: - Views
    
    private lazy var screenTitle: UILabel = {
        let label = UILabel()
        label.text = "Тестовое задание"
        label.font = .systemFont(ofSize: 26, weight: .black)
        return label
    }()
    private lazy var chatTableView: ChatTableView = {
        let tableView = ChatTableView()
        tableView.eventsDelegate = self
        return tableView
    }()
    private lazy var textViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    private lazy var textView: DynamicalTextView = {
        let textView = DynamicalTextView()
        textView.delegate = self
        textView.placeholder = "Сообщение"
        textView.backgroundColor = .systemBackground
        textView.layer.cornerRadius = 8
        textView.layer.borderColor = UIColor.placeholderText.cgColor
        textView.layer.borderWidth = 0.5
        textView.font = .systemFont(ofSize: 16, weight: .regular)
        return textView
    }()
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 24)
        button.setImage(UIImage(systemName: "arrow.up.circle.fill", withConfiguration: configuration), for: .normal)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        button.tintColor = .textColor
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupKeyboardObservers()
        Task {
            await presenter?.fetchMessages(offset: 0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupInterface()
    }
    
    // MARK: - Setups
    
    private func setupInterface() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemBackground
    }
    
    private func setupConstraints() {
        view.addSubview(screenTitle)
        view.addSubview(chatTableView)
        view.addSubview(textViewContainer)
        textViewContainer.addSubview(textView)
        textViewContainer.addSubview(sendButton)
        
        screenTitle.translatesAutoresizingMaskIntoConstraints = false
        screenTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        screenTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        
        chatTableView.translatesAutoresizingMaskIntoConstraints = false
        chatTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        chatTableView.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 8).isActive = true
        chatTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        chatTableView.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: -16).isActive = true
        
        textViewContainer.translatesAutoresizingMaskIntoConstraints = false
        textViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        textViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        textViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        textView.topAnchor.constraint(equalTo: textViewContainer.topAnchor, constant: 8).isActive = true
        textView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Actions
    
    @objc private func sendMessage() {
        if let text = textView.text, !text.trimmingCharacters(in: .whitespaces).isEmpty {
            let message = MessageViewModel(id: String(0), image: "https://www.shareicon.net/data/128x128/2015/06/22/58079_smith_512x512.png", incoming: false, message: text, date: Date().toString(time: .short))
            chatTableView.messages.append(message)
            CoreDataService.shared.saveData(message: message)
            
            Task {
                try await Task.sleep(nanoseconds: 100_000_000)
                chatTableView.scrollToBottom(isAnimated: false)
            }
        }
        textView.text = ""
        textView.resignFirstResponder()
    }
    
    
    //MARK: - MessageDetailViewProtocol
    
    func deleteMessage(at index: Int) {
        if chatTableView.messages[index].incoming == false {
            CoreDataService.shared.deleteEntity(message: chatTableView.messages[index])
        }
        
        chatTableView.messages.remove(at: index)
    }
    
}

//MARK: - ChatScreen Methods

extension ChatScreenViewController: ChatScreen {
    func updateView(_ messages: [String]) async {
        var messagesArray: [MessageViewModel] = []
        messages.indices.forEach {
            messagesArray.append(MessageViewModel(id: String($0), image: "https://cdn1.iconfinder.com/data/icons/diversity-avatars-volume-1-heads/64/matrix-neo-man-white-512.png", incoming: true, message: messages[$0], date: Date().toString(time: .short)))}
        
        if let savedMessages = await presenter?.fetchSavedMessages() {
            messagesArray.append(contentsOf: savedMessages)
            chatTableView.savedMessagesCount = savedMessages.count
        }
        
        chatTableView.messages = messagesArray.sorted(by: { Int($0.id)! > Int($1.id)! })
        guard chatTableView.messages.isEmpty == false, messages.count <= 20 else {
            return
        }
        
        chatTableView.scrollToBottom(isAnimated: false)
    }
}

//MARK: - ChatTableViewProtocol

extension ChatScreenViewController: ChatTableViewProtocol {
    func requestForNextPage(offset: Int) {
        Task {
            await presenter?.fetchMessages(offset: offset)
        }
    }
    
    func showMessageDetail(with message: MessageViewModel, at index: Int) {
        presenter?.showMessageDetailScreen(message, at: index)
    }
}

//MARK: - UITextViewDelegate

extension ChatScreenViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard chatTableView.messages.isEmpty == false else {
            return
        }
        
        Task {
            try await Task.sleep(nanoseconds: 10_000_000)
            chatTableView.scrollToBottom(isAnimated: false)
        }
    }
    
}

//MARK: - Keyboard Notifications

extension ChatScreenViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

