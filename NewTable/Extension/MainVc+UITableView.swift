//
//  MainVc+UITableView.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/2/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

extension MainVC {

     //MARK: - UITableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

       // let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellId)

        let course = courses[indexPath.row]
        cell.textLabel?.text = course.body
        cell.detailTextLabel?.text = course.title

        return cell
    }

    //MARK: UITableView Delegate Method
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let delete = deleteTableViewCellWithSwipeAction(at: indexPath)

        //save data to core data
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.persistence.save()
        }
        
        return UISwipeActionsConfiguration(actions: [delete])


    }


}
