//
//  ErrorView.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 08.09.2022.
//

import UIKit

final class ErrorView: UIView {
    
    //MARK: - Views
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.placeholderText.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 16
        view.backgroundColor = .systemBackground
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [title, errorLabel, suggestActionLabel, buttonsStackView])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 12
        stackView.alignment = .center
        return stackView
    }()
    private lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Ошибка!"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    private lazy var suggestActionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Попробовать еще раз?"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cancelButton, doneButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 12
        return stackView
    }()
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.backgroundColor = .blue
        button.layer.masksToBounds = true
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.backgroundColor = .red
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    //MARK: - Properties
    
    private var doneButtonCompletion: () -> ()  = {}
    private var cancelButtonCompletion: () -> ()  = {}
    
    //MARK: - Lifecycle
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupConstraints()
    }
    
    //MARK: - Setup
    
    private func setupConstraints() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 12.0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.0).isActive = true
        
        containerView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12.0).isActive = true
        mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12.0).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12.0).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12.0).isActive = true
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor).isActive = true
    }
    
    //MARK: - Actions
    
    @objc private func doneButtonAction() {
        doneButtonCompletion()
        removeFromSuperview()
    }
    
    @objc private func cancelButtonAction() {
        cancelButtonCompletion()
        removeFromSuperview()
    }
    
}

extension ErrorView: Configurable {
    struct ErrorViewModel {
        let errorMessage: String
        let doneButtonTitle: String
        let cancelButtonTitle: String
        let doneButtonAction: () -> ()
        let cancelButtonAction: () -> () = {}
    }
    
    typealias Model = ErrorViewModel
    
    func configure(with model: ErrorViewModel) {
        errorLabel.text = model.errorMessage
        doneButton.setTitle(model.doneButtonTitle, for: .normal)
        cancelButton.setTitle(model.cancelButtonTitle, for: .normal)
        doneButtonCompletion = model.doneButtonAction
        cancelButtonCompletion = model.cancelButtonAction
    }
    
}
