//
//  ArticleEntity+CoreDataProperties.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/14/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension ArticleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleEntity> {
        return NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
    }

    @NSManaged public var comments: Int64
    @NSManaged public var content: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var id: String?
    @NSManaged public var likes: Int64
    @NSManaged public var mediaRelation: NSSet?
    @NSManaged public var userRelation: NSSet?

}

// MARK: Generated accessors for mediaRelation
extension ArticleEntity {

    @objc(addMediaRelationObject:)
    @NSManaged public func addToMediaRelation(_ value: MediaEntity)

    @objc(removeMediaRelationObject:)
    @NSManaged public func removeFromMediaRelation(_ value: MediaEntity)

    @objc(addMediaRelation:)
    @NSManaged public func addToMediaRelation(_ values: NSSet)

    @objc(removeMediaRelation:)
    @NSManaged public func removeFromMediaRelation(_ values: NSSet)

}

// MARK: Generated accessors for userRelation
extension ArticleEntity {

    @objc(addUserRelationObject:)
    @NSManaged public func addToUserRelation(_ value: UserEntity)

    @objc(removeUserRelationObject:)
    @NSManaged public func removeFromUserRelation(_ value: UserEntity)

    @objc(addUserRelation:)
    @NSManaged public func addToUserRelation(_ values: NSSet)

    @objc(removeUserRelation:)
    @NSManaged public func removeFromUserRelation(_ values: NSSet)

}
