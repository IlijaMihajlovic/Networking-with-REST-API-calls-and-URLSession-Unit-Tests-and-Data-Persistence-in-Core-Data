//
//  Networking.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/2/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import Foundation

extension MainVC {

    // MARK - Fetch JSON Data
    func fetchJSON(url: URL, completion: @escaping (Result<[PostCore], NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) {(data, response, error) in

            guard let jsonData = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 || httpResponse.statusCode == 200, error == nil else {

                if let error = error as NSError?, error.domain == NSURLErrorDomain {

                    completion(.failure(.domainError))
                    completion(.failure(.responseError))
                }
                return
            }

            //Get some Data beck
            do {
                guard let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]] else {return}

                let posts: [PostCore] = json.compactMap { [weak self] in

                    //Since we're in a closure and we using weak self here we need to make sure we are unwraping our regular self
                    guard let strongSelf = self,
                        let userId = $0["userId"] as? Int32,
                        let id =  $0["id"] as? Int32,
                        let body = $0["body"] as? String,
                        let title = $0["title"] as? String else {return nil}

                    let post = PostCore(context: strongSelf.persistence.context)
                    post.userId = userId
                    post.id = id
                    post.body = body
                    post.title = title
                    return post
                }
                print(posts)
                completion(.success(posts))

                self.courses = posts

                //save data to core data
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.persistence.save()
                        

                    //self.tableView.reloadData()

                }


            } catch {
                completion(.failure(.decodingError))
            }
            } .resume()
    }
}



// MARK: - Send API Request
extension MainVC {

    //Return a message in case of a success or an API Error if something went wrong
    func save(_ messageToSave: Message ,completion: @escaping(Result<Message, NetworkError>) -> Void) {

        let resourceString = "https://jsonplaceholder.typicode.com/posts"

        guard let resourceURL = URL(string: resourceString) else { fatalError()}

        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

            //encode our message text to JSON
            urlRequest.httpBody = try JSONEncoder().encode(messageToSave)

            // Creates a task that retrieves the contents of a URL based on the specified URL request object, and calls a handler upon completion.
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

                guard let jsonData = data, error == nil, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 || httpResponse.statusCode == 200 else {

                    if let error = error as NSError?, error.domain == NSURLErrorDomain {

                        //if there was a problem we have an error and we can't proceed so we return
                        completion(.failure(.domainError))
                        completion(.failure(.responseError))
                    }
                    return
                }

                do {

                    let messageData = try JSONDecoder().decode(Message.self, from: jsonData)

                    //this was successful so we can pass along our message data object
                    completion(.success(messageData))
                    //print("Awsome \(messageData.userId), \(messageData.title)")


                } catch {
                    completion(.failure(.decodingError))
                }
            } .resume() //Resume the task

        } catch {
            completion(.failure(.encodingError))
        }
    }
}

