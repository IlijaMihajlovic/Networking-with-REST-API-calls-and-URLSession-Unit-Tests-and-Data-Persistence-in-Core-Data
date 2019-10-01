//
//  SetRadius.swift
//  rationaleTech
//
//  Created by Ilija Mihajlovic on 9/18/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

extension UIView {
    func setRadius(radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2;
        self.layer.masksToBounds = true;
    }
}
