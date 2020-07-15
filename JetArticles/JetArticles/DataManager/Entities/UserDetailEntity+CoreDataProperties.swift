//
//  UserDetailEntity+CoreDataProperties.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/14/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension UserDetailEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDetailEntity> {
        return NSFetchRequest<UserDetailEntity>(entityName: "UserDetailEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var city: String
    @NSManaged public var lastname: String
    @NSManaged public var avatar: String
    @NSManaged public var name: String
    @NSManaged public var createdAt: String
    @NSManaged public var designation: String
    @NSManaged public var about: String

}
