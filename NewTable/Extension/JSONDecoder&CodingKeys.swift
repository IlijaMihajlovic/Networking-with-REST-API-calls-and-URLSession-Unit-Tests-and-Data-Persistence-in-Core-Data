//
//  JSONDecoder&CodingKeys.swift
//  rationaleTech
//
//  Created by Ilija Mihajlovic on 9/24/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import Foundation
import CoreData

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
}

extension JSONDecoder {
    convenience init(context: NSManagedObjectContext) {
        self.init()
        self.userInfo[.context] = context
    }
}
