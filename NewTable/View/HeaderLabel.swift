//
//  HeaderLabel.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/31/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

class HeaderLabel : UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .mainAppOrange
        textColor = .white
        textAlignment = .center
        font = UIFont.boldSystemFont(ofSize: 14)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override var intrinsicContentSize: CGSize {
        let originalContentSize = super.intrinsicContentSize
        let height = originalContentSize.height + 18
        layer.cornerRadius = height / 2
        layer.masksToBounds = true
        return CGSize(width: originalContentSize.width + 24, height: originalContentSize.height + 18)
    }
}
