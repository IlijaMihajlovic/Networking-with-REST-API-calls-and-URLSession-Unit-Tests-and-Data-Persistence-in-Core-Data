//
//  ViewController.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/1/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

enum NetworkError: Error {

    case domainError
    case decodingError
    case responseError
    case encodingError
}

class ViewController: UITableViewController {

    var courses: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Course List"
        addBarButtonItems()
    }

    fileprivate func addBarButtonItems() {
        let get = UIBarButtonItem(title: "GET", style: .plain, target: self, action: #selector(handleGet))
        navigationItem.rightBarButtonItems = [get]
        print("HIiiiiiiii")
    }

   @objc func handleGet() {

    let url = "https://jsonplaceholder.typicode.com/posts"
    guard let unwrappedurl = URL(string: url) else { return }

    fetchCoursesJSON(url: unwrappedurl) { (result) in

        switch result {

        case .success(let posts):

            posts.forEach({ (post) in
                print("JSON Data: \(post.body), \(post.title)")

            })

        case .failure(let err):
            print("Failed to fetch courses", err)
        }
    }


    }


     func fetchCoursesJSON(url: URL, completion: @escaping (Result<[Post], NetworkError>) -> Void) {
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

extension ViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        let course = courses[indexPath.row]
        cell.textLabel?.text = course.body
        cell.detailTextLabel?.text = String(course.title)
        return cell
    }
}

