//
//  User+CoreDataClass.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 10/1/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Decodable {

    private enum CodingKeys: String, CodingKey { case address ,company, avatar, email, id, name, phone, username, website }
     
     required convenience public init(from decoder: Decoder) throws {
         
         guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError("NSManagedObjectContext is missing") }
         
         let entity = NSEntityDescription.entity(forEntityName: "User", in: context)!
         self.init(entity: entity, insertInto: context)
         
         let values = try decoder.container(keyedBy: CodingKeys.self)
         
         address = try values.decode(Address.self, forKey: .address)
         avatar = try values.decode(String.self, forKey: .avatar)
         company = try values.decode(Company.self, forKey: .company)
         email = try values.decode(String.self, forKey: .email)
         id = try values.decode(Int32.self, forKey: .id)
         name = try values.decode(String.self, forKey: .name)
         phone = try values.decode(String.self, forKey: .phone)
         username = try values.decode(String.self, forKey: .username)
         website = try values.decode(String.self, forKey: .website)
    
     }
}
