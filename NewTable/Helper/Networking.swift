//
//  Networking.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/2/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import Foundation

struct Networking {
    
    //Singleton
    private init() {}
    static let shared = Networking()
    
    // MARK - Fetch JSON Data
    func fetchJSON(url: URL, completion: @escaping (Result<[User], NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            guard let jsonData = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 || httpResponse.statusCode == 200, error == nil else {
                
                if let error = error as NSError?, error.domain == NSURLErrorDomain {
                    
                    completion(.failure(.domainError))
                    completion(.failure(.responseError))
                }
                return
            }
            
            //MARK: Get Data Back
            do {
                
                let decoder = JSONDecoder.init(context: PersistenceService.shared.persistentContainer.viewContext)
                
                let data = try decoder.decode([User].self, from: jsonData)
                HomeController.shared.usersArray = data
                
                let users = User(context: PersistenceService.shared.persistentContainer.viewContext)
                
                data.forEach { (user) in
                    users.address = user.address as Address
                    users.avatar = user.avatar
                    users.company = user.company as Company
                    users.email = user.email
                    users.id = user.id
                    users.name = user.name
                    users.phone = user.phone
                }
                
                completion(.success(data))
                HomeController.shared.usersArray = data
                
                data.forEach { (user) in
                    // print("City: \(user.address.geo.lng)")
                    print("LNG: \(user.address.geo.lng)")
                    print("company: \(user.company.name), \(user.company.bs)")
                    
                }
                
                DispatchQueue.main.async {
                    HomeController.shared.tableView.reloadData()
                    HomeController.shared.persistence.save()
                }
                
            } catch {
                completion(.failure(.decodingError))
            }
        } .resume()
    }
    
    
    
    
    // MARK: - Send API Request
    
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
                    print("Awsome \(messageData.userId), \(messageData.title)")
                    
                    
                } catch {
                    completion(.failure(.decodingError))
                }
            } .resume() //Resume the task
        } catch {
            completion(.failure(.encodingError))
        }
    }
}







