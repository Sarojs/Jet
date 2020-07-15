//
//  UserDetail.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/14/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import Foundation

struct UserDetail {
    let id: String
    let createdAt: String
    let name: String
    let avatar: String
    let lastname: String
    let city: String
    let designation: String
    let about: String
}

extension UserDetail: Decodable {
    
    enum UserDetailKeys: CodingKey {
        case id
        case createdAt
        case name
        case lastname
        case city
        case designation
        case about
        case avatar
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try! decoder.container(keyedBy: UserDetailKeys.self)
        
        self.id = try! container.decode(String.self, forKey: .id)
        self.createdAt = try! container.decode(String.self, forKey: .createdAt)
        self.name = try! container.decode(String.self, forKey: .name)
        self.lastname = try! container.decode(String.self, forKey: .lastname)
        self.city = try! container.decode(String.self, forKey: .city)
        self.designation = try! container.decode(String.self, forKey: .designation)
        self.about = try! container.decode(String.self, forKey: .about)
        self.avatar = try! container.decode(String.self, forKey: .avatar)
    }
}
