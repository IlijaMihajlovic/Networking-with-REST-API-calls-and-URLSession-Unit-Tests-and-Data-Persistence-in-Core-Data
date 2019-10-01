//
//  Company+CoreDataClass.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 10/1/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Company)
public class Company: NSManagedObject, Decodable {

    private enum CodingKeys: String, CodingKey { case bs, catchPhrase, name }

          required convenience public init(from decoder: Decoder) throws {
              
              guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError("NSManagedObjectContext is missing") }
              
              let entity = NSEntityDescription.entity(forEntityName: "Company", in: context)!
              self.init(entity: entity, insertInto: context)
              
              let values = try decoder.container(keyedBy: CodingKeys.self)
              
                bs = try values.decode(String.self, forKey: .bs)
                catchPhrase = try values.decode(String.self, forKey: .catchPhrase)
                name = try values.decode(String.self, forKey: .name)
              
        }
    
}
