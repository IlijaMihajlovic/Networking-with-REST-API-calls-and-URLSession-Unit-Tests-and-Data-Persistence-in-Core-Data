//
//  NetworkError.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/1/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import Foundation

//Possible errors we can encounter
enum NetworkError: Error {

    case domainError
    case decodingError
    case responseError
    case encodingError
}
