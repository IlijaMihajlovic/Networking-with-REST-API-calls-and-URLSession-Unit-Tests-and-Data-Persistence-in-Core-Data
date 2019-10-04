//
//  UITableViewDelegateMethods.swift
//  DarwinDigital
//
//  Created by Ilija Mihajlovic on 9/11/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

//MARK: - UITableView Delegate Method

extension HomeController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailVC.shared
        detailVC.addAtrributedText(from: tableView, inviewController: detailVC)
 
        UIView.transition(with: tableView,duration:0.27,options:.transitionCrossDissolve,animations: { () -> Void in
            
            self.navigationController?.pushViewController(detailVC, animated: true)
        
        }, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

           let label = HeaderLabel()
           label.text = "Users"

           let containerView = UIView()
           containerView.addSubview(label)
           label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
           label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true

           return containerView
       }

}



