//
//  ViewController.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/1/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

final class MainVC: UITableViewController {

    var courses: [Post] = []
    let cellId = "cellId"

    static let shared = MainVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)

        configureNav()
        addBarButtonItems()
    }


    fileprivate func addBarButtonItems() {
        let get = UIBarButtonItem(title: "GET", style: .plain, target: self, action: #selector(printJSON))
        navigationItem.rightBarButtonItems = [get]

    }

    fileprivate func configureNav() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Course List"
    }


    @objc fileprivate func printJSON() {
        let url = "https://jsonplaceholder.typicode.com/posts"
        guard let urlString = URL(string: url) else { return }

        fetchJSON(url: urlString) { (result) in

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

}





