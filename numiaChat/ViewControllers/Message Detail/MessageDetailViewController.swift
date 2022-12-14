//
//  MessageDetailViewController.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 09.09.2022.
//

import UIKit

protocol MessageDetailViewProtocol: AnyObject {
    func deleteMessage(at index: Int)
}

final class MessageDetailViewController: UIViewController {
    
    //MARK: - Delegate
    
    weak var delegate: MessageDetailViewProtocol?
    
    //MARK: - Properties
    
    var index: Int
    var message: MessageViewModel
    
    init(index: Int, message: MessageViewModel) {
        self.index = index
        self.message = message
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Views
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 100
        imageView.layer.masksToBounds = true
        imageView.tintColor = .textColor
        imageView.alpha = 0
        return imageView
    }()
    private lazy var messageStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, messageLabel])
        stackView.layer.cornerRadius = 12
        stackView.backgroundColor = .secondarySystemBackground
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 12
        stackView.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.alpha = 0
        return stackView
    }()
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.alpha = 0
        return label
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.alpha = 0
        return label
    }()
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 12
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("?????????????? ??????????????????", for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        button.alpha = 0
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        setupConstraints()
        setupContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.33) { [unowned self] in
            [avatarImageView, messageStackView, messageLabel, dateLabel, deleteButton].forEach( {$0.alpha = 1} )
        }
    }
    
    //MARK: - Setups
    
    private func setupInterface() {
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .systemBackground
    }
    
    private func setupConstraints() {
        view.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        view.addSubview(messageStackView)
        messageStackView.translatesAutoresizingMaskIntoConstraints = false
        messageStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        messageStackView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16).isActive = true
        messageStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        view.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        deleteButton.topAnchor.constraint(equalTo: messageStackView.bottomAnchor, constant: 16).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupContent() {
        messageLabel.text = message.message
        dateLabel.text = message.date
        avatarImageView.loadFrom(URLAddress: message.image ?? "")
    }
    
    //MARK: - Actions
    
    @objc private func deleteButtonAction () {
        delegate?.deleteMessage(at: index)
        Router.shared.pop(animated: true)
    }
    
}
