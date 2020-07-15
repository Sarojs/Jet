//
//  UserCellViewModel.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/14/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import Foundation

class UserCellViewModel {
    
    private var entity: UserDetailEntity
    
    var userEntity: UserDetailEntity {
        return self.entity
    }
    
    var username: String {
        return "\(self.entity.name) \(self.entity.lastname)"
    }
    
    var designation: String {
        return self.entity.designation
    }
    
    var avatar: String {
        return self.entity.avatar
    }
    
    var city: String {
        return self.entity.city
    }
    
    var about: String {
        return self.entity.about
    }
    
    init(entity: UserDetailEntity) {
        self.entity = entity
    }
}
