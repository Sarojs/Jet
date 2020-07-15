//
//  UserService.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/13/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import Foundation

struct UserService: Service {
    
    typealias ResponseType = [UserDetail]
    typealias CompletionCallback = (ServiceResult<[UserDetail]>) -> Void
    typealias Page = (pageIndex: Int, pageSize: Int)
    
    private let endPoint: EndPoint = .userDetails
    
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
                
                let users = try JSONDecoder().decode([UserDetail].self, from: data!)
                completion(ServiceResult.success(users))
                
            } catch let error {
                
                debugPrint(error.localizedDescription)
                completion(ServiceResult.failed)
            }
        }
    }
}

private extension UserService {
    
    var compiledEndpoint: String {
        return self.endPoint.rawValue + "page=\(self.page.pageIndex)&limit=\(self.page.pageSize)"
    }
}
