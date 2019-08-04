//
//  PostModelObject+CoreDataProperties.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 8/4/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//
//

import Foundation
import CoreData


extension PostModelObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostModelObject> {
        return NSFetchRequest<PostModelObject>(entityName: "PostModelObject")
    }

    @NSManaged public var body: String?
    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var userId: Int32

}
