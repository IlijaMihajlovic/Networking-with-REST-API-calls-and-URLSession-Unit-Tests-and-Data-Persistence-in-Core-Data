//
//  APIRequest.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/1/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import Foundation

//final class APIRequest: NSObject {
//
//    static let shared = APIRequest()
//
//    private override init() {}
//
//    func fetchCoursesJSON(url: URL, completion: @escaping (Result<[Post], NetworkError>) -> Void) {
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            guard let jsonData = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, error == nil else {
//
//                if let error = error as NSError?, error.domain == NSURLErrorDomain {
//
//                    completion(.failure(.domainError))
//                    completion(.failure(.responseError))
//
//                }
//                return
//            }
//
//            do {
//                let posts = try JSONDecoder().decode([Post].self, from: jsonData)
//                ViewController.shared.courses = posts
//
//                completion(.success(posts))
//
////               DispatchQueue.main.async {
////                    ViewController.shared.tableView.reloadData()
////              }
//
//            } catch {
//                completion(.failure(.decodingError))
//            }
//            } .resume()
//    }
//}
