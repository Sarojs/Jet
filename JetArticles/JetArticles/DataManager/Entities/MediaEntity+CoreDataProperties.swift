//
//  MediaEntity+CoreDataProperties.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/14/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension MediaEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MediaEntity> {
        return NSFetchRequest<MediaEntity>(entityName: "MediaEntity")
    }

    @NSManaged public var blogId: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}
