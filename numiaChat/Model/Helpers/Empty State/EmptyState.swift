//
//  EmptyState.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 08.09.2022.
//

import UIKit

protocol EmptyStateProtocol {
    func showInternetRequestErrorView(with model: ErrorView.ErrorViewModel)
}

extension UIViewController: EmptyStateProtocol {
    func showInternetRequestErrorView(with model: ErrorView.ErrorViewModel) {
        let errorView = ErrorView()
        errorView.configure(with: model)
        guard let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
            .filter({$0.isKeyWindow}).first else {
            return
        }
        keyWindow.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.centerYAnchor.constraint(equalTo: keyWindow.centerYAnchor).isActive = true
        errorView.leadingAnchor.constraint(equalTo: keyWindow.leadingAnchor, constant: 20).isActive = true
        errorView.trailingAnchor.constraint(equalTo: keyWindow.trailingAnchor, constant: -20).isActive = true
    }
   
}

