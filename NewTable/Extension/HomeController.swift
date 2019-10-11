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
    
    
    lazy var customRefreshControl: UIRefreshControl = {
          var refreshControl = UIRefreshControl()
          refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
          refreshControl.addTarget(self, action: #selector(refreshCollectionViewPulled), for: .valueChanged)
          return refreshControl
      }()
    
    
    lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "more")?.withRenderingMode(.alwaysTemplate), for: .normal)
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
        configureRefreshController()
        addViewToSubview()
        getJSONDataAndCheckForPossibleErrors()
        
        //Load data from Core Data
        persistence.fetch(User.self) { [weak self] (posts) in
            self?.incomingDataArray = posts
            
        }
    }
 
    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Search Bar Methods
    @objc fileprivate func handleShowSearchBar() {
        showSearchBar(shouldShow: true)
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
    }
    
    fileprivate func showBarButtonItems(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar)),UIBarButtonItem(customView: moreButton)]
            
        } else {
            navigationItem.rightBarButtonItems = nil
        }
    }
    
    func showSearchBar(shouldShow: Bool) {
        //If the search bar is shown then disable the bar button item(the opposite of the argument shouldShow)
        showBarButtonItems(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar: nil
    }
    
    
    // MARK: Table View Methods
    fileprivate func setupTableView() {
         tableView.backgroundColor = .white
         tableView.separatorStyle = .none
         tableView.refreshControl = customRefreshControl
         tableView.register(CustomCell.self, forCellReuseIdentifier: tableViewCellId)
     }
     
     @objc func sortTableViewbyUsername() {
            incomingDataArray.sort { $0.username < $1.username } //sort username by ascending order
            tableView.reloadData()
        }
    
    
    fileprivate func configureNav() {
        navigationItem.title = "Users"
    }
    
    @objc fileprivate func handleMore() {
          SettingsLauncher.shared.showSettings()
      }
    
    
    //MARK: - Refresh Controller Methods
    fileprivate func configureRefreshController() {
         let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
         customRefreshControl.attributedTitle = NSAttributedString(string: "", attributes: attributes)
               
     }
    
    @objc func refreshCollectionViewPulled(refreshControl: UIRefreshControl) {
           print("Refresh")
           getJSONDataAndCheckForPossibleErrors()
           
           DispatchQueue.main.async {
               self.tableView.reloadData()
           }
           
           refreshControl.endRefreshing()
           
       }
    
    //MARK: - Check JSON Data For Possible Errors
    @objc func getJSONDataAndCheckForPossibleErrors() {
        guard let urlString = URL(string: urlToApi) else { return }
        
        Networking.shared.fetchJSON(url: urlString) {(result) in
            
            switch result {
            case .success(let posts):
                posts.forEach({ (post) in
                    //print("JSON Data: \(post.address.city), \(post.company.name)")
                })
                
            case .failure(let err):
                print("Failed to fetch courses", err)
            }
        }
    }
    
    
    //MARK: - Add View To Subview
    fileprivate func addViewToSubview() {
           [customRefreshControl].forEach{view.addSubview($0)}
       }
    
    
    //MARK: - Send Message to API
    @objc  func sendMessage() {
        
        let alert = UIAlertController(title: "Send Message", message: nil, preferredStyle: .alert)
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
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object:alert.textFields?[2], queue: OperationQueue.main) { (notification) -> Void in
                                                
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





