//
//  ArticleService.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/13/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import Foundation

/// The service structure to fetch articles
struct ArticleService: Service {
    
    typealias ResponseType = [Article]
    typealias CompletionCallback = (ServiceResult<[Article]>) -> Void
    typealias Page = (pageIndex: Int, pageSize: Int)
    
    private let endPoint: EndPoint = .articles
    
    var page: Page = (0, 0) // Just a default to start with
    
    init(pageIndex: Int, pageSize: Int) {
        self.page = (pageIndex, pageSize)
    }
    
    func execute(completion: @escaping CompletionCallback) {
        
        debugPrint(self.compiledEndpoint)
        
        let message = HttpMessage()
        
        message.execute(imageURL: self.compiledEndpoint) { (data, response, error) in
            
            guard error == nil else {
                
                debugPrint(error?.localizedDescription ?? "")
                
                completion(ServiceResult.failed)
                return
            }
            
            do {
                
                let articles = try JSONDecoder().decode([Article].self, from: data!)
                completion(ServiceResult.success(articles))
                
            } catch let error {
                
                debugPrint(error.localizedDescription)
                completion(ServiceResult.failed)
            }
        }
    }
}

private extension ArticleService {
    
    var compiledEndpoint: String {
        return self.endPoint.rawValue + "page=\(self.page.pageIndex)&limit=\(self.page.pageSize)"
    }
}
