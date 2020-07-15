//
//  UserDetailViewModel.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/14/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import Foundation
import CoreData

class UserDetailViewModel {
    
    private var entity: UserDetailEntity
    
    var avatar: String {
        return self.entity.avatar
    }
    
    var name: String {
        return "\(self.entity.name) \(self.entity.lastname)"
    }
    
    var designation: String {
        return self.entity.designation
    }
    
    var city: String {
        return self.entity.city
    }
    
    var about: String {
        return self.entity.about
    }
    
    init(with entity: UserDetailEntity) {
        self.entity = entity
    }
}
