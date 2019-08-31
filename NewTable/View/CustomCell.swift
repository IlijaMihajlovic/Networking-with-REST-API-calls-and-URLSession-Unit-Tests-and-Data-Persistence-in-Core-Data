//
//  CustomCell.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/31/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title: "
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
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 4).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 4).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    fileprivate func addViewToSubView() {
        addSubview(titleLabel)
    }
}

