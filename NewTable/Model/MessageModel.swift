//
//  Model.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/1/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import Foundation

//JSON Model
final class Message: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String

    init(userId: Int ,id: Int, title: String, body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}
