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
    
    func save() {
        let context = getContext()
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func createObject<T: NSManagedObject> (from entity: T.Type) -> T {
        let context = getContext()
        let object = NSEntityDescription.insertNewObject(forEntityName: String(describing: entity), into: context) as! T
        return object
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
}
