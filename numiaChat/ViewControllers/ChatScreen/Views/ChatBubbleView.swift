//
//  BubbleView.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 07.09.2022.
//

import UIKit

final class ChatBubbleView: UIView {
    
    //MARK: - Views
    
    let bubbleLayer = CAShapeLayer()
    let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 1
        return label
    }()
    
    //MARK: - Properties
    
    var isIncoming = false
    var timeLabelLeadingOrTrailingConstraint = NSLayoutConstraint()

    //MARK: - Lifecycle
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupConstraints()
    }

    //MARK: - Setups
    
    private func setupConstraints() {
        layer.addSublayer(bubbleLayer)
        addSubview(messageLabel)
        addSubview(timeLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12.0).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: timeLabel.topAnchor, constant: -12.0).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0).isActive = true
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.0).isActive = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let width = bounds.size.width + 80
        let height = bounds.size.height
        let bezierPath = UIBezierPath()
        timeLabelLeadingOrTrailingConstraint.isActive = false
        
        switch isIncoming {
        case true:
            bezierPath.move(to: CGPoint(x: 22, y: height))
            bezierPath.addLine(to: CGPoint(x: width - 17, y: height))
            bezierPath.addCurve(to: CGPoint(x: width, y: height - 17), controlPoint1: CGPoint(x: width - 7.61, y: height), controlPoint2: CGPoint(x: width, y: height - 7.61))
            bezierPath.addLine(to: CGPoint(x: width, y: 17))
            bezierPath.addCurve(to: CGPoint(x: width - 17, y: 0), controlPoint1: CGPoint(x: width, y: 7.61), controlPoint2: CGPoint(x: width - 7.61, y: 0))
            bezierPath.addLine(to: CGPoint(x: 21, y: 0))
            bezierPath.addCurve(to: CGPoint(x: 4, y: 17), controlPoint1: CGPoint(x: 11.61, y: 0), controlPoint2: CGPoint(x: 4, y: 7.61))
            bezierPath.addLine(to: CGPoint(x: 4, y: height - 11))
            bezierPath.addCurve(to: CGPoint(x: 0, y: height), controlPoint1: CGPoint(x: 4, y: height - 1), controlPoint2: CGPoint(x: 0, y: height))
            bezierPath.addLine(to: CGPoint(x: -0.05, y: height - 0.01))
            bezierPath.addCurve(to: CGPoint(x: 11.04, y: height - 4.04), controlPoint1: CGPoint(x: 4.07, y: height + 0.43), controlPoint2: CGPoint(x: 8.16, y: height - 1.06))
            bezierPath.addCurve(to: CGPoint(x: 22, y: height), controlPoint1: CGPoint(x: 16, y: height), controlPoint2: CGPoint(x: 19, y: height))
            bezierPath.close()
            
            timeLabelLeadingOrTrailingConstraint = timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0)
        case false:
            bezierPath.move(to: CGPoint(x: width - 22, y: height))
            bezierPath.addLine(to: CGPoint(x: 17, y: height))
            bezierPath.addCurve(to: CGPoint(x: 0, y: height - 17), controlPoint1: CGPoint(x: 7.61, y: height), controlPoint2: CGPoint(x: 0, y: height - 7.61))
            bezierPath.addLine(to: CGPoint(x: 0, y: 17))
            bezierPath.addCurve(to: CGPoint(x: 17, y: 0), controlPoint1: CGPoint(x: 0, y: 7.61), controlPoint2: CGPoint(x: 7.61, y: 0))
            bezierPath.addLine(to: CGPoint(x: width - 21, y: 0))
            bezierPath.addCurve(to: CGPoint(x: width - 4, y: 17), controlPoint1: CGPoint(x: width - 11.61, y: 0), controlPoint2: CGPoint(x: width - 4, y: 7.61))
            bezierPath.addLine(to: CGPoint(x: width - 4, y: height - 11))
            bezierPath.addCurve(to: CGPoint(x: width, y: height), controlPoint1: CGPoint(x: width - 4, y: height - 1), controlPoint2: CGPoint(x: width, y: height))
            bezierPath.addLine(to: CGPoint(x: width + 0.05, y: height - 0.01))
            bezierPath.addCurve(to: CGPoint(x: width - 11.04, y: height - 4.04), controlPoint1: CGPoint(x: width - 4.07, y: height + 0.43), controlPoint2: CGPoint(x: width - 8.16, y: height - 1.06))
            bezierPath.addCurve(to: CGPoint(x: width - 22, y: height), controlPoint1: CGPoint(x: width - 16, y: height), controlPoint2: CGPoint(x: width - 19, y: height))
            bezierPath.close()
            
            timeLabelLeadingOrTrailingConstraint = timeLabel.leadingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 22)
        }
        
        timeLabelLeadingOrTrailingConstraint.isActive = true
        bubbleLayer.fillColor = isIncoming ? UIColor.secondarySystemFill.cgColor : UIColor.secondaryLabel.cgColor
        bubbleLayer.path = bezierPath.cgPath
    }
}
