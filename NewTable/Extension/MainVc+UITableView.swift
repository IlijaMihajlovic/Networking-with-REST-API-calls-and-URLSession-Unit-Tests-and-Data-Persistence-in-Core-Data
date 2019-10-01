//
//  MainVc+UITableView.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/2/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

extension HomeController {

     //MARK: - UITableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

       let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomCell
     
        
        cell.avatar.image = nil
        cell.tag = indexPath.row
        
        cell.address.text = "City: " +  usersArray[indexPath.row].address.city
        cell.companyName.text = "Company: " + usersArray[indexPath.row].company.name
        cell.username.text =  "Username: " + usersArray[indexPath.row].username
        
        cell.email.text = usersArray[indexPath.row].email
        cell.street.text = usersArray[indexPath.row].address.street
        cell.phone.text = usersArray[indexPath.row].phone
        
        
        let url  = URL(string: usersArray[indexPath.row].avatar)
             DispatchQueue.main.async {

                 if cell.tag == indexPath.row {
                     ImageService.getImage(withURL: url!) { (image) in
                         cell.avatar.image = image
                     }

                 }

             }
        return cell
    }
    

    //Save Data to Core Data when right-swipe to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {

            let task = usersArray.remove(at: indexPath.row)

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


