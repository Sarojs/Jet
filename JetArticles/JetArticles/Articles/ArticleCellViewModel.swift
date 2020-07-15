//
//  ArticleCellViewModel.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/12/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import Foundation
import CoreData

class ArticleCellViewModel {
    
    private var entity: ArticleEntity
    
    lazy var username: String? = {
        guard let user = Array(self.entity.userRelation!).first as? UserEntity, let name = user.name, let lastname = user.lastname else {
            return nil
        }
        return "\(name) \(lastname)"
    }()
    
    lazy var designation: String? = {
        guard let user = Array(self.entity.userRelation!).first as? UserEntity, let designation = user.designation else {
            return nil
        }
        return designation
    }()
    
    lazy var time: String? = {
        guard let createdAt = self.entity.createdAt, let date = Date.InDateFormatter.date(from: createdAt) else {
            return nil
        }
        let string = Date.OutDateFormatter.string(from: date, to: Date())
        return string
    }()
    
    lazy var avatar: String? = {
        guard let user = Array(self.entity.userRelation!).first as? UserEntity, let avatar = user.avatar else {
            return nil
        }
        return avatar
    }()
    
    lazy var mediaImage: String? = {
        guard let media = Array(self.entity.mediaRelation!).first as? MediaEntity, let image = media.image else {
            return nil
        }
        return image
    }()
    
    lazy var content: String? = {
        return self.entity.content
    } ()
    
    lazy var like: String? = {
        return "\(self.entity.likes/1000)K" + " Likes"
    }()
    
    lazy var comment: String? = {
        return "\(self.entity.comments/1000)K" + " Comments"
    }()
    
    init(entity: ArticleEntity) {
        self.entity = entity
    }
}
