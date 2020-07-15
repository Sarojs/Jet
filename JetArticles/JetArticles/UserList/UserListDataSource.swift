//
//  UserListDataSource.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/14/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import Foundation
import CoreData

class UserListDataSource {
    
    typealias Completion = ([UserDetailEntity]?, Error?) -> Void
    
    let pageSize: Int = 10
    
    private var requestStatus: RequestStatus = .completed
    
    var isRequestInProgress: Bool {
        return self.requestStatus == .inProgress
    }
    
    var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchUserList(pageIndex: Int, completion: @escaping Completion) {
        
        // Don't send another request if one is in progress already
        guard self.requestStatus != .inProgress else { return }
        
        let isConnected = Reachability().isConnectedToNetwork()
        
        guard isConnected else {
            let entities = self.readUsers()
            completion(entities, nil)
            return
        }
        
        UserService(pageIndex: pageIndex, pageSize: pageSize).execute { result in
            switch result {
            case .success(let users):
                self.requestStatus = .completed
                self.save(userDetails: users)
                let entities = self.readUsers()
                completion(entities, nil)
            case .failed:
                self.requestStatus = .failed
                break
            }
        }
    }
    
    /// Read entities from CoreData
    func readUsers() -> [UserDetailEntity]? {
        
        let context = PersistentDataManager.shared.persistentContainer.viewContext
        
        let request = NSFetchRequest<UserDetailEntity>(entityName: "UserDetailEntity")
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

private extension UserListDataSource {
    
    func save(userDetails user: [UserDetail]) {
        
        for user in user {
            
            let entityUser = NSEntityDescription.entity(forEntityName: "UserDetailEntity", in: context)

            let newUser = NSManagedObject(entity: entityUser!, insertInto: context)
            
            newUser.setValue(user.id, forKey: "id")
            newUser.setValue(user.createdAt, forKey: "createdAt")
            newUser.setValue(user.about, forKey: "about")
            newUser.setValue(user.city, forKey: "city")
            newUser.setValue(user.designation, forKey: "designation")
            newUser.setValue(user.name, forKey: "name")
            newUser.setValue(user.lastname, forKey: "lastname")
            newUser.setValue(user.avatar, forKey: "avatar")
        }
        
        PersistentDataManager.shared.saveContext()
    }
}
