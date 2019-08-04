//
//  PostCore+CoreDataProperties.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/3/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//
//

import Foundation
import CoreData


extension PostCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostCore> {
        return NSFetchRequest<PostCore>(entityName: "PostCore")
    }

    @NSManaged public var userId: Int32
    @NSManaged public var id: Int32
    @NSManaged public var title: String
    @NSManaged public var body: String

}
