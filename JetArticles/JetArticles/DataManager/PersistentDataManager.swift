//
//  PersistentDataManager.swift
//  JetArticles
//
//  Created by Saroj Sharma on 7/12/20.
//  Copyright © 2020 Jet2 Travel Technologies. All rights reserved.
//

import Foundation
import CoreData

struct PersistentDataManager {
    
    private init() { }
    
    private static var coreDataManager = PersistentDataManager()
    
    static var shared: PersistentDataManager { return self.coreDataManager }
    
    var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "JetArticles")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
