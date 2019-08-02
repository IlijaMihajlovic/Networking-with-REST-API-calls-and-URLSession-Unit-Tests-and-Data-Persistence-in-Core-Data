//
//  Post.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/2/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import Foundation

//JSON Model
struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
