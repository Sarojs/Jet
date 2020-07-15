//
//  ArticlesDataSource.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/12/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import Foundation
import CoreData

class ArticlesDataSource {
    
    typealias Completion = ([ArticleEntity]?, Error?) -> Void
    
    let pageSize: Int = 10
    
    private var requestStatus: RequestStatus = .completed
    
    var isRequestInProgress: Bool {
        return self.requestStatus == .inProgress
    }
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchArticle(pageIndex: Int, completion: @escaping Completion) {
        
        // Don't send another request if one is in progress already
        guard self.requestStatus != .inProgress else { return }
        
        let isConnected = Reachability().isConnectedToNetwork()
        
        guard isConnected else {
            let entities = self.readArticles()
            completion(entities, nil)
            return
        }
        
        self.requestStatus = .inProgress
        ArticleService(pageIndex: pageIndex, pageSize: pageSize).execute { result in
            switch result {
            case .success(let articles):
                self.requestStatus = .completed
                self.save(articles: articles)
                let entities = self.readArticles()
                completion(entities, nil)
            case .failed:
                self.requestStatus = .failed
                break
            }
        }
    }
    
    /// Read entities from CoreData
    func readArticles() -> [ArticleEntity]? {
        
        let context = PersistentDataManager.shared.persistentContainer.viewContext
        
        let request = NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
        request.returnsObjectsAsFaults = false
        
        do {
            
            let result = try context.fetch(request)
            return result
            
        } catch {
            let fetchError = error as NSError
            debugPrint(fetchError)
        }
        return nil
    }
}

private extension ArticlesDataSource {
    
    func save(articles: [Article]) {
        
        for anArticle in articles {
            
            let entityArticle = NSEntityDescription.entity(forEntityName: "ArticleEntity", in: context)
            
            let newArticle = NSManagedObject(entity: entityArticle!, insertInto: context)
            
            newArticle.setValue(anArticle.id, forKey: "id")
            newArticle.setValue(anArticle.createdAt, forKey: "createdAt")
            newArticle.setValue(anArticle.content, forKey: "content")
            newArticle.setValue(anArticle.comments, forKey: "comments")
            newArticle.setValue(anArticle.likes, forKey: "likes")
            
            // Try saving media
            if let media = anArticle.media.first {
                
                let entityMedia = NSEntityDescription.entity(forEntityName: "MediaEntity", in: context)
                let newMedia = NSManagedObject(entity: entityMedia!, insertInto: context)
                
                newMedia.setValue(media.id, forKey: "id")
                newMedia.setValue(media.blogId, forKey: "blogId")
                newMedia.setValue(media.createdAt, forKey: "createdAt")
                newMedia.setValue(media.image, forKey: "image")
                newMedia.setValue(media.title, forKey: "title")
                newMedia.setValue(media.url, forKey: "url")
                
                newArticle.setValue(NSSet(array: [newMedia]), forKey: "mediaRelation")
            }
            
            // Try saving user
            if let user = anArticle.user.first {
                
                let entityUser = NSEntityDescription.entity(forEntityName: "UserEntity", in: context)
                let newUser = NSManagedObject(entity: entityUser!, insertInto: context)
                
                newUser.setValue(user.id, forKey: "id")
                newUser.setValue(user.blogId, forKey: "blogId")
                newUser.setValue(user.createdAt, forKey: "createdAt")
                newUser.setValue(user.about, forKey: "about")
                newUser.setValue(user.city, forKey: "city")
                newUser.setValue(user.designation, forKey: "designation")
                newUser.setValue(user.name, forKey: "name")
                newUser.setValue(user.lastname, forKey: "lastname")
                newUser.setValue(user.avatar, forKey: "avatar")
                
                newArticle.setValue(NSSet(array: [newUser]), forKey: "userRelation")
            }
        }
        
        PersistentDataManager.shared.saveContext()
    }
}
