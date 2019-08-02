//
//  Networking.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/2/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import Foundation

extension MainVC {

    // API Request
    func fetchJSON(url: URL, completion: @escaping (Result<[Post], NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in

            guard let jsonData = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, error == nil else {

                if let error = error as NSError?, error.domain == NSURLErrorDomain {

                    completion(.failure(.domainError))
                    completion(.failure(.responseError))
                }
                return
            }

            do {
                let posts = try JSONDecoder().decode([Post].self, from: jsonData)
                self.courses = posts

                completion(.success(posts))

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            } catch {
                completion(.failure(.decodingError))
            }
            } .resume()
    }

}
