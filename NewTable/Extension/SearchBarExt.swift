//
//  SearchBarExt.swift
//  DarwinDigital
//
//  Created by Ilija Mihajlovic on 9/11/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

extension HomeController: UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        showSearchBar(shouldShow: false)
        searchBar.text = ""
        isSearching = false
        animateTableViewWhileReloading()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text != "" {
            
            // Enable search with lowercase and uppercase letters
            filterdArray = incomingDataArray.filter({$0.username.lowercased().uppercased().prefix(searchText.count) == searchText.lowercased().uppercased()})
        }
        
        isSearching = true
        animateTableViewWhileReloading()
    }
    
    
    fileprivate func animateTableViewWhileReloading() {
        UIView.transition(with: tableView,duration:0.27,options:.transitionCrossDissolve,animations: { () -> Void in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }, completion: nil)
    }
    
}
