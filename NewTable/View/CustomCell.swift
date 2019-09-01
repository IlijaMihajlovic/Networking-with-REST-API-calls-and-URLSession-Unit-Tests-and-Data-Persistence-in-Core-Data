//
//  CustomCell.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/31/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userId: UILabel = {
        let label = UILabel()
        label.text = "ID: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViewToSubView()
        addConstraints()
       
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addConstraints() {
        titleLabel.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: messageLabel.leadingAnchor, padding: .init(top: 5, left: 10, bottom: 0, right: 0 ))

        messageLabel.anchor(top: titleLabel.topAnchor, bottom: bottomAnchor, leading: titleLabel.leadingAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 60, bottom: 10, right: 0))
        
        userId.anchor(top: nil, bottom: messageLabel.bottomAnchor, leading: titleLabel.leadingAnchor, trailing: messageLabel.leadingAnchor)
    }
    
    
    
    fileprivate func addViewToSubView() {
        [titleLabel, messageLabel, userId].forEach{addSubview($0)}
        
    }
}

