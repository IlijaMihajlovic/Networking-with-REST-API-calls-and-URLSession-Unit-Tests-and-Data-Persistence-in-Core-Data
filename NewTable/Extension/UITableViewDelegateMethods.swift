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

}



