//
//  CoreDateStack.swift
//  Navigation
//
//  Created by Егор Никитин on 16.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStack { 
    
    static let sharedInstance = CoreDataStack()
    
    lazy var persistentStoreContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoritPostModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        }
        return container
    }()
    
    func getContext()  -> NSManagedObjectContext {
        persistentStoreContainer.viewContext
    }
    
    func getBackgroundContext() -> NSManagedObjectContext {
        persistentStoreContainer.newBackgroundContext()
    }
    
    func save(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func createObject(author: String?, description: String?, image: Data?, likes: String?, views: String?) {
        let context = getBackgroundContext()
        context.perform {
            let favoritPost = NSEntityDescription.insertNewObject(forEntityName: String(describing: FavoritPost.self), into: context) as! FavoritPost
            favoritPost.author = author
            favoritPost.desc = description
            favoritPost.image = image
            favoritPost.likes = likes
            favoritPost.views = likes
            self.save(context: context)
        }
        
    }
    
    func delete(object: NSManagedObject) {
        let context = getContext()
        context.delete(object)
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchData<T: NSManagedObject>(for entity: T.Type) -> [T] {
        let context = getContext()
        let request = entity.fetchRequest() as! NSFetchRequest<T>
        
        do {
            return try context.fetch(request)
        } catch {
            fatalError()
        }
    }
    
    func searchObjects<T: NSManagedObject, String>(for entity: T.Type, author: String) -> [T] {
        let context = getContext()
        let request = entity.fetchRequest() as! NSFetchRequest<T>
        request.entity = FavoritPost.entity()
        let predicate = NSPredicate(format: "%K LIKE %@", #keyPath(FavoritPost.author), "\(author)")
        request.predicate = predicate
        
        do {
            return try context.fetch(request)
        } catch {
            fatalError()
        }
    }
}
