//
//  User+CoreDataProperties.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 10/1/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var avatar: String
    @NSManaged public var email: String
    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var phone: String
    @NSManaged public var username: String
    @NSManaged public var website: String
    @NSManaged public var address: Address
    @NSManaged public var company: Company

}
