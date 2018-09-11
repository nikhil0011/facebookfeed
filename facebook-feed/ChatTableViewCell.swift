
//
//  ChatTableViewCell.swift
//  facebook-feed
//
//  Created by Admin on 9/10/18.
//  Copyright © 2018 demo. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!

    var chatMessage: ChatMessages!{
        didSet{
            messageLabel.text = chatMessage.message
            bubbleBackgroundView.backgroundColor = chatMessage.incomingMessage ? .white : UIColor.rgb(red: 37, green: 211, blue: 102)
            messageLabel.textColor = chatMessage.incomingMessage ? .black : .white
            if chatMessage.incomingMessage {
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false

            }else{
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            }
        }
    }
    
    let bubbleBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let messageLabel: UILabel = {
        let label  = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = .clear
        
        self.addSubview(bubbleBackgroundView)
        self.addSubview(messageLabel)
        let constraints =
        [messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
        bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8),
        bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8),
        bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -8),
        bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 8)
        ]
        NSLayoutConstraint.activate(constraints)
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        
        
    }
    
}
