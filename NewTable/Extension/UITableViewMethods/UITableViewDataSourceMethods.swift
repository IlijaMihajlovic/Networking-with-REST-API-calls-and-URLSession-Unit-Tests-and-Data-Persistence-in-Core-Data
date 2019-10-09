//
//  UITableViewDataSourceMethods.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/2/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

//MARK: - UITableView Data Source Methods

extension HomeController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        isSearching ? filterdArray.count: incomingDataArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellId, for: indexPath) as! CustomCell
        
        if isSearching {
            searchBarIsSeraching(with: filterdArray, and: cell, atIndexPath: indexPath)

        } else {
            searchBarIsSeraching(with: incomingDataArray, and: cell, atIndexPath: indexPath)
           
        }
        
        return cell
    }
    
    
    
    //TODO: - Potential for using generics
    func searchBarIsSeraching(with modelData: [User], and cell: CustomCell, atIndexPath: IndexPath) {
        
        cell.avatar.image = nil
        cell.tag = atIndexPath.row

        cell.address.text = "City: " +  modelData[atIndexPath.row].address.city
        cell.companyName.text = "Company: " + modelData[atIndexPath.row].company.name
        cell.username.text =  "Username: " + modelData[atIndexPath.row].username
        
        cell.email.text = modelData[atIndexPath.row].email
        cell.street.text = modelData[atIndexPath.row].address.street
        cell.phone.text = modelData[atIndexPath.row].phone
        
        //Download Image, assign it and Cache it
        let url  = URL(string: modelData[atIndexPath.row].avatar)
        DispatchQueue.main.async {
            
            if cell.tag == atIndexPath.row {
                ImageService.getImage(withURL: url!) { (image) in
                    cell.avatar.image = image
                }
            }
        }
    }
  
    
    //Save Data to Core Data when right-swipe to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let task = incomingDataArray.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            PersistenceService.shared.delete(task)
            tableView.endUpdates()
            PersistenceService.shared.save()
            
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        }
    }
    
}


