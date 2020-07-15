//
//  Article.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/11/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import Foundation

struct Article {
    let id: String
    let createdAt: String
    let content: String
    let comments: Int
    let likes: Int
    let media: [Media]
    let user: [User]
}

extension Article: Decodable {
    
    enum ArticleKeys: CodingKey {
        case id
        case createdAt
        case content
        case comments
        case likes
        case media
        case user
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try! decoder.container(keyedBy: ArticleKeys.self)

        self.id = try! container.decode(String.self, forKey: .id)
        self.createdAt = try! container.decode(String.self, forKey: .createdAt)
        self.content = try! container.decode(String.self, forKey: .content)
        self.comments = try! container.decode(Int.self, forKey: .comments)
        self.likes = try! container.decode(Int.self, forKey: .likes)
        self.media = try! container.decode([Media].self, forKey: .media)
        self.user = try! container.decode([User].self, forKey: .user)
    }
}
