//
//  DetailVC.swift
//  DarwinDigital
//
//  Created by Ilija Mihajlovic on 9/12/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    static let shared = DetailVC()
    
     //MARK: - Propeties
    let mainView: UIView = {
        let showV = UIView()
        showV.setRadius(radius: 14)
        showV.backgroundColor = .white
        showV.translatesAutoresizingMaskIntoConstraints = false
        return showV
    }()
    
    let avatar: UIImageView = {
        let avatarImage = UIImageView()
        avatarImage.backgroundColor = .white
        avatarImage.setRadius(radius: 14)
        avatarImage.contentMode = .scaleAspectFill
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        return avatarImage
    }()
    
     let descriptionTextView: UITextView = {
        let textView = UITextView()

        let attributedText = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])

        attributedText.append(NSAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    
     //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customGray
        addViewToSubView()
        addConstraints()
    }
    
    private init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //TODO: - Potential for using generics
    func addAtrributedText(from tableView: UITableView, inviewController: DetailVC, at indexPath: IndexPath? = nil) {
        
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let currentCell = tableView.cellForRow(at: indexPath) as! CustomCell
        
        let attributedText = NSMutableAttributedString(string: currentCell.username.text ?? "", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSAttributedString(string: "\n\(currentCell.address.text ?? "")", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\nStreet: \(currentCell.street.text ?? "")", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\nPhone: \(currentCell.phone.text ?? "")", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\nEmail: \(currentCell.email.text ?? "")", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        inviewController.avatar.image = currentCell.avatar.image
        inviewController.descriptionTextView.attributedText = attributedText
        inviewController.descriptionTextView.textAlignment = .center
        
    }
   
    //MARK: - Constraints and Add Subview Functions
    fileprivate func addConstraints() {
        
        mainView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 16, left: 10, bottom: 16, right: 10))
        
        avatar.anchor(top: mainView.topAnchor, bottom: nil, leading: mainView.leadingAnchor, trailing: mainView.trailingAnchor,  padding: .init(top: 0, left: 0, bottom: 5, right: 0))
        
        avatar.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.6).isActive = true
        
        descriptionTextView.anchor(top: avatar.bottomAnchor, bottom: mainView.bottomAnchor, leading: mainView.leadingAnchor, trailing: mainView.trailingAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        
    }
    
    fileprivate func addViewToSubView() {
        [mainView, avatar, descriptionTextView].forEach{view.addSubview($0)}
    }
}
