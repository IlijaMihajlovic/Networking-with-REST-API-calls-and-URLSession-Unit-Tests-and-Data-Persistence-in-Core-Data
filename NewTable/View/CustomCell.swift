//
//  CustomCell.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/31/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    //MARK: - Propeties
    let bubbleBackground: UIView = {
        let bubbleView = UIView()
        bubbleView.layer.cornerRadius = 16
        bubbleView.backgroundColor =  .mainAppOrange
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        return bubbleView
    }()
    
    let userInfoContainerView: UIView = {
         let containerView = UIView()
          containerView.translatesAutoresizingMaskIntoConstraints = false
          return containerView
      }()
    
    let address: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let companyName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let username: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let avatar: UIImageView = {
        let avatarImage = UIImageView()
        avatarImage.setRadius(radius: 14)
        avatarImage.contentMode = .scaleAspectFill
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        return avatarImage
    }()
    
    let email: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let street: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phone: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    //MARK: - Cell Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        addViewToSubview()
        addConstraints()
       
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Constraints and Add Subview Functions
    fileprivate func addConstraints() {
        bubbleBackground.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 16, bottom: 12, right: 16))
        
        userInfoContainerView.anchor(top: bubbleBackground.topAnchor, bottom: bubbleBackground.bottomAnchor, leading: avatar.trailingAnchor, trailing: bubbleBackground.trailingAnchor)
        
       avatar.anchor(top: bubbleBackground.topAnchor, bottom: bubbleBackground.bottomAnchor, leading: bubbleBackground.leadingAnchor, trailing: nil, padding: .init(top: 5, left: 5, bottom: 5, right: 5), size: .init(width: 90, height: 90))

        username.anchor(top: avatar.topAnchor, bottom: address.topAnchor, leading: userInfoContainerView.leadingAnchor, trailing: userInfoContainerView.trailingAnchor, padding: .init(top: 3, left: 5, bottom: 0, right: 0))
        
        
        companyName.anchor(top: address.bottomAnchor, bottom: userInfoContainerView.bottomAnchor, leading: userInfoContainerView.leadingAnchor, trailing: userInfoContainerView.trailingAnchor, padding: .init(top: 0, left: 5, bottom: 5, right: 0))
        

        NSLayoutConstraint.activate([
            address.centerXAnchor.constraint(equalTo: userInfoContainerView.centerXAnchor),
            address.heightAnchor.constraint(equalTo: userInfoContainerView.heightAnchor, multiplier: 0.5),
            address.leadingAnchor.constraint(equalTo: userInfoContainerView.leadingAnchor, constant: 5)
            ])

    }
    
    fileprivate func addViewToSubview() {
        addSubview(bubbleBackground)
        [avatar, userInfoContainerView].forEach{bubbleBackground.addSubview($0)}
        [username, address, companyName].forEach{userInfoContainerView.addSubview($0)}
    }
    
    
}
