//
//  Address+CoreDataProperties.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 10/1/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//
//

import Foundation
import CoreData


extension Address {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest<Address>(entityName: "Address")
    }

    @NSManaged public var city: String
    @NSManaged public var street: String
    @NSManaged public var suite: String
    @NSManaged public var zipcode: String
    @NSManaged public var geo: Geo

}
