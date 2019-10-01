//
//  Address+CoreDataClass.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 10/1/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Address)
public class Address: NSManagedObject, Decodable {

    private enum CodingKeys: String, CodingKey { case geo, city, street, suite, zipcode }

          required convenience public init(from decoder: Decoder) throws {
              
              guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError("NSManagedObjectContext is missing") }
              
              let entity = NSEntityDescription.entity(forEntityName: "Address", in: context)!
              self.init(entity: entity, insertInto: context)
              
              let values = try decoder.container(keyedBy: CodingKeys.self)
                 
                  street = try values.decode(String.self, forKey: .street)
                  suite = try values.decode(String.self, forKey: .suite)
                  city = try values.decode(String.self, forKey: .city)
                  zipcode = try values.decode(String.self, forKey: .zipcode)
                  geo = try values.decode(Geo.self, forKey: .geo)
        }
    
}
