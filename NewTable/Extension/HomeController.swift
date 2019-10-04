//
//  ViewController.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/1/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

final class HomeController: UITableViewController {
    
    //Singleton
    static let shared = HomeController()
    
    //MARK: - Properties
    var isSearching = false
    var incomingDataArray = [User]()
    var filterdArray = [User]()
    
    lazy fileprivate var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        return searchBar
    }()
    
    lazy fileprivate var sortBarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sort", for: .normal)
        button.addTarget(self, action: #selector(sortTableViewbyUsername), for: .touchUpInside)
        button.frame = CGRect(x: 1, y: 0, width: 45, height: 45)
        return button
    }()
    
    lazy var sendBarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var moreButton: UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("More", for: .normal)
         button.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        button.addTarget(self, action: #selector(handleMore), for: .touchUpInside)
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
     }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        showBarButtonItems(shouldShow: true)
        configureNav()
        checkJSONDataForPossibleErrors()
        
        //Load data from Core Data
        persistence.fetch(User.self) { [weak self] (posts) in
            self?.incomingDataArray = posts
        }
    }
    
    
    fileprivate func setupTableView() {
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(CustomCell.self, forCellReuseIdentifier: cellId)
    }
      
    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Search Bar Button Function
       @objc fileprivate func handleShowSearchBar() {
           showSearchBar(shouldShow: true)
           searchBar.becomeFirstResponder()
           searchBar.delegate = self
       }
    
    fileprivate func showBarButtonItems(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar)),
                                                  UIBarButtonItem(customView: moreButton)]
            
               navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: sendBarButton), UIBarButtonItem(customView: sortBarButton)]
            
        } else {
            navigationItem.rightBarButtonItems = nil
            navigationItem.leftBarButtonItems = nil

        }
    }
    
    func showSearchBar(shouldShow: Bool) {
           //If the search bar is shown then disable the bar button item(the opposite of the argument shouldShow)
           showBarButtonItems(shouldShow: !shouldShow)
           searchBar.showsCancelButton = shouldShow
           navigationItem.titleView = shouldShow ? searchBar: nil
       }
    
    @objc fileprivate func sortTableViewbyUsername() {
        incomingDataArray.sort { $0.username < $1.username } //sort username by ascending order
        tableView.reloadData()
    }
    
    fileprivate func configureNav() {
        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Users"
    }
    
    let settingsLauncher = SettingsLauncher()
    @objc fileprivate func handleMore() {
        settingsLauncher.showSettings()
    }
    
    //MARK: - Check JSON Data For Possible Errors
    @objc fileprivate func checkJSONDataForPossibleErrors() {
        guard let urlString = URL(string: urlToApi) else { return }
        
        Networking.shared.fetchJSON(url: urlString) {(result) in
            
            switch result {
            case .success(let posts):
                posts.forEach({ (post) in
                    print("JSON Data: \(post.address.city), \(post.company.name)")
                })
                
            case .failure(let err):
                print("Failed to fetch courses", err)
            }
        }
    }
    
    
    //MARK: - Send Message to API
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
            
            Networking.shared.save(message, completion: { result in
                
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





