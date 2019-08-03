//
//  ViewController.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/1/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

final class MainVC: UITableViewController {

    let persistence = PersistenceService.shared

    lazy var getBarButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        //button.backgroundColor = UIColor.orange
        button.addTarget(self, action: #selector(printJSONData), for: .touchUpInside)
        button.frame = CGRect(x: 1, y: 0, width: 35, height: 35)

        return button
    }()

    lazy var sendBarButton: UIButton = {
        var button = UIButton(type: .system)
        button.setTitle("SEND", for: .normal)
        //button.backgroundColor = UIColor.orange
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    var courses: [PostCore] = []
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        configureNav()
        //addBarButtonItems()



        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: getBarButton)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: sendBarButton)



    }


    fileprivate func addBarButtonItems() {
        let getButton = UIBarButtonItem(title: "GET", style: .plain, target: self, action: #selector(printJSONData))
        getButton.tintColor = .orange

        let sendButton = UIBarButtonItem(title: "SEND", style: .done, target: self, action: #selector(sendMessage))
        sendButton.tintColor = .purple
        navigationItem.rightBarButtonItems = [getButton, sendButton]
    }

    
    fileprivate func configureNav() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Course List"
    }

    func deleteTableViewCellWithSwipeAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.courses.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = .orange
        return action
    }


    @objc fileprivate func printJSONData() {
        let url = "https://jsonplaceholder.typicode.com/posts"
        guard let urlString = URL(string: url) else { return }

        fetchJSON(url: urlString) { (result) in

            switch result {
            case .success(let posts):


               posts.forEach({ (post) in
                   print("JSON Data: \(post.body), \(post.title), \(post.userId)")
             })

            case .failure(let err):
                print("Failed to fetch courses", err)
            }
        }
    }


    @objc fileprivate func sendMessage() {

        let alert = UIAlertController(title: "API Request", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        let sendAction = UIAlertAction(title: "Send", style: .default) { (action: UIAlertAction!) -> Void in

            guard let userid2 = alert.textFields?[0].text else { return }
            let userId: Int = Int(userid2)!

            guard let id2 = alert.textFields?[1].text! else { return }
            let id: Int = Int(id2)!

            guard let title = alert.textFields?[2].text! else { return }
            guard let body = alert.textFields?[3].text! else { return }

            let message = Message(userId: userId, id: id, title: title, body: body)

            self.save(message, completion: { result in

                switch result {
                case .success(let message):
                    print("It's Working: \(message.title), \(message.body), \(message.userId) ")

                case .failure(let error):
                    print("An error occured \(error)")
                }
            })
        }


        sendAction.isEnabled = false

        alert.addTextField {
            (textFieldUserIdAsNumber: UITextField!) in
            textFieldUserIdAsNumber.placeholder = "User ID As Number"
            textFieldUserIdAsNumber.keyboardType = .numberPad
        }

        alert.addTextField {
            (textFieldApiId: UITextField!) in
            textFieldApiId.placeholder = "API ID as Number"
            textFieldApiId.keyboardType = .numberPad
        }

        alert.addTextField {
            (textFieldMessage: UITextField!) in
            textFieldMessage.placeholder = "Message Title as String"
            textFieldMessage.keyboardType = .alphabet
        }

        alert.addTextField {
            (textFieldMessage: UITextField!) in
            textFieldMessage.placeholder = "Message Body as String"
            textFieldMessage.keyboardType = .alphabet
        }


        guard let userIdAsNumber = alert.textFields?[0], let apiId = alert.textFields?[1], let apiMessage = alert.textFields?[2], let apiBody = alert.textFields?[3] else { return }

        //MARK: UserID TextField
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object:alert.textFields?[0], queue: OperationQueue.main) { (notification) -> Void in

            //Disable the button if one those requirements aren't met
            sendAction.isEnabled = !userIdAsNumber.text!.isEmpty && !userIdAsNumber.text!.isNumeric && !apiId.text!.isEmpty && !apiMessage.text!.isEmpty && !apiMessage.text!.isNumeric && !apiBody.text!.isEmpty && !apiBody.text!.isNumeric
        }

        //MARK: IDTextField
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object:alert.textFields?[1], queue: OperationQueue.main) { (notification) -> Void in

            sendAction.isEnabled = !apiId.text!.isEmpty && apiId.text!.isNumeric && !userIdAsNumber.text!.isEmpty && userIdAsNumber.text!.isNumeric && !apiMessage.text!.isEmpty && !apiMessage.text!.isNumeric && !apiBody.text!.isEmpty && !apiBody.text!.isNumeric
        }

        //MARK: MessageTextField
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object:alert.textFields?[2],
        queue: OperationQueue.main) { (notification) -> Void in

            sendAction.isEnabled = !apiMessage.text!.isEmpty && apiId.text!.isNumeric && !userIdAsNumber.text!.isEmpty && userIdAsNumber.text!.isNumeric && !apiMessage.text!.isEmpty && !apiMessage.text!.isNumeric && !apiBody.text!.isEmpty && !apiBody.text!.isNumeric
        }

        //MARK: BodyTextField
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: alert.textFields?[3], queue: OperationQueue.main) { (notification) -> Void in

            sendAction.isEnabled = !apiBody.text!.isEmpty && !apiBody.text!.isNumeric && !apiMessage.text!.isEmpty && apiId.text!.isNumeric && !userIdAsNumber.text!.isEmpty && userIdAsNumber.text!.isNumeric && !apiMessage.text!.isEmpty && !apiMessage.text!.isNumeric
        }

        alert.addAction(sendAction)
        alert.addAction(cancelAction)
        present(alert,animated: true,completion: nil)
        }

    }





