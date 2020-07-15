//
//  Media.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/14/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import Foundation

struct Media {
    let id: String
    let blogId: String
    let createdAt: String
    let image: String
    let title: String
    let url: String
}

extension Media: Decodable {
    
    enum MediaKeys: CodingKey {
        case id
        case blogId
        case createdAt
        case image
        case title
        case url
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try! decoder.container(keyedBy: MediaKeys.self)
        
        self.id = try! container.decode(String.self, forKey: .id)
        self.blogId = try! container.decode(String.self, forKey: .blogId)
        self.createdAt = try! container.decode(String.self, forKey: .createdAt)
        self.image = try! container.decode(String.self, forKey: .image)
        self.title = try! container.decode(String.self, forKey: .title)
        self.url = try! container.decode(String.self, forKey: .url)
    }
}
