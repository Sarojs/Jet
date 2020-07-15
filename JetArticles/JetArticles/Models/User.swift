//
//  User.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/14/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import Foundation

struct User {
    let id: String
    let blogId: String
    let createdAt: String
    let name: String
    let lastname: String
    let city: String
    let designation: String
    let about: String
    let avatar: String
}

extension User: Decodable {
    
    enum UserKeys: CodingKey {
        case id
        case blogId
        case createdAt
        case name
        case lastname
        case city
        case designation
        case about
        case avatar
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try! decoder.container(keyedBy: UserKeys.self)
        
        self.id = try! container.decode(String.self, forKey: .id)
        self.blogId = try! container.decode(String.self, forKey: .blogId)
        self.createdAt = try! container.decode(String.self, forKey: .createdAt)
        self.name = try! container.decode(String.self, forKey: .name)
        self.lastname = try! container.decode(String.self, forKey: .lastname)
        self.city = try! container.decode(String.self, forKey: .city)
        self.designation = try! container.decode(String.self, forKey: .designation)
        self.about = try! container.decode(String.self, forKey: .about)
        self.avatar = try! container.decode(String.self, forKey: .avatar)
    }
}
