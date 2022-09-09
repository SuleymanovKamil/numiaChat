//
//  Loadable.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 08.09.2022.
//


import UIKit

protocol Loadable {
    func showLoading()
    func hideLoading()
}

extension Loadable {
    func showLoading() {
        guard let self = self as? UIViewController else { return }
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.tag = 096
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    func hideLoading() {
        guard let `self` = self as? UIViewController else { return }
        guard let loadingView = self.view.viewWithTag(096) else { return }
        loadingView.removeFromSuperview()
        self.view.isUserInteractionEnabled = true
    }
}

