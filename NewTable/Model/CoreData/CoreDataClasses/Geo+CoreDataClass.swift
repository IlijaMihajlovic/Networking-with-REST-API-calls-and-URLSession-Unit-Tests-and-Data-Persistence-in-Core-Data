//
//  Geo+CoreDataClass.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 10/1/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Geo)
public class Geo: NSManagedObject, Decodable {

    private enum CodingKeys: String, CodingKey { case lat, lng}

         required convenience public init(from decoder: Decoder) throws {
             
             guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError("NSManagedObjectContext is missing") }
             
             let entity = NSEntityDescription.entity(forEntityName: "Geo", in: context)!
             self.init(entity: entity, insertInto: context)
             
             let values = try decoder.container(keyedBy: CodingKeys.self)
             
               lat = try values.decode(String.self, forKey: .lat)
               lng = try values.decode(String.self, forKey: .lng)
       }
    
}
