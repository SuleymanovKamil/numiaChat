//
//  DynamicalTextView.swift
//  Fundea
//
//  Created by Bogdan Filippov on 01.08.2021.
//

import UIKit

class DynamicalTextView: UITextView {
    
    // MARK: - Properties
    
    override var text: String? {
        didSet {
            changeTextViewFrame()
        }
    }
    var placeholder: String? = "Placeholder" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
   
    // MARK: - Interface Properties
    
    var placeholderColor: UIColor = .placeholderText {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    override var font: UIFont? {
        didSet {
            placeholderLabel.font = font
        }
    }
    override var bounds: CGRect {
        didSet {
            changeTextViewFrame()
        }
    }
    
    // MARK: - Views
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = placeholder
        label.font = font
        label.textColor = placeholderColor
        return label
    }()
    
    // MARK: - Constraints
    
    private lazy var textViewHeightConstraint: NSLayoutConstraint = {
        return heightAnchor.constraint(equalToConstant: font?.lineHeight ?? 16)
    }()
    private lazy var placeholderLeftConstraint: NSLayoutConstraint = {
        return placeholderLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8)
    }()
    private lazy var placeholderTopConstraint: NSLayoutConstraint = {
        return placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10)
    }()
    private lazy var placeholderRightConstraint: NSLayoutConstraint = {
        return placeholderLabel.rightAnchor.constraint(equalTo: rightAnchor)
    }()
    private lazy var placeholderBottomConstraint: NSLayoutConstraint = {
        return placeholderLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    }()
    
    // MARK: - Lifecycle
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupTextView()
        setupSubviews()
        setupConstraints()
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if newWindow != nil {
            changeTextViewFrame()
            setupObservers()
        } else {
            removeObservers()
        }
    }
    
    // MARK: - Setups
    
    private func setupTextView() {
        isScrollEnabled = false
        textContainerInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        textContainer.lineFragmentPadding = 0
    }
    
    private func setupSubviews() {
        if placeholderLabel.superview == nil {
            addSubview(placeholderLabel)
        }
    }
    
    private func setupConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        textViewHeightConstraint.isActive = true
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLeftConstraint.isActive = true
        placeholderTopConstraint.isActive = true
        placeholderRightConstraint.isActive = true
        placeholderBottomConstraint.isActive = true
        
        changeTextViewFrame()
    }
    
    // MARK: - Layout Managements
    
    private func changeTextViewFrame() {
        placeholderLabel.isHidden = text?.count ?? 0 > 0
        let fixedWidth = layer.frame.size.width
        let newSize = sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT)))
        
        guard newSize.height < UIScreen.main.bounds.height / 3 else {
            return
        }
        
        if textViewHeightConstraint.constant != newSize.height {
            var newFrame = frame
            newFrame.size = CGSize(width: CGFloat(fmaxf(Float(newSize.width), Float(fixedWidth))), height: newSize.height)
            textViewHeightConstraint.constant = newSize.height
        }
    }
    
    // MARK: - Observation Setups
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChangeNotification), name: UITextView.textDidChangeNotification, object: self)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Observation Actions
    
    @objc private func textDidChangeNotification(_ notification: Notification) {
        changeTextViewFrame()
    }
    
}
