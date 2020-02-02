//
//  CoreDataManager.swift
//  MovieDB
//
//  Created by yakup caglan on 31.01.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import CoreData

protocol CoreDataProtocol: class {
    func fetch<M : NSManagedObject>(dbEntity : M.Type) throws -> [M]
    func delete(by managedObjectID: NSManagedObjectID) throws
    func insert<M : NSManagedObject>(type : M.Type , changeOnObject : (M) -> Void) throws
    func update<M : NSManagedObject>(newObject : M.Type , managedObjectID : NSManagedObjectID , changeOnObject: (M?) -> Void) throws
}

final public class CoreDataManager: CoreDataProtocol {
        
    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "FavoritedTVShow")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext() throws {
        let context = persistentContainer.viewContext

        guard context.hasChanges else { return }

        try context.save()
    }

    func fetch<M: NSManagedObject>(dbEntity: M.Type) throws -> [M] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: dbEntity.description())

        var result = [M]()

        let records = try persistentContainer.viewContext.fetch(fetchRequest)

        if let records = records as? [M] {
            result = records
        }

        return result
    }

    func delete(by managedObjectID: NSManagedObjectID) throws {
        let managedObject = persistentContainer.viewContext.object(with: managedObjectID)
        persistentContainer.viewContext.delete(managedObject)

        try saveContext()
    }

    func insert<M: NSManagedObject>(type: M.Type, changeOnObject: (M) -> Void) throws {
        let newObject = M(context: persistentContainer.viewContext)

        changeOnObject(newObject)

        try saveContext()
    }

    func update<M: NSManagedObject>(newObject: M.Type, managedObjectID: NSManagedObjectID, changeOnObject: (M?) -> Void) throws {
        let managedObject = persistentContainer.viewContext.object(with: managedObjectID) as? M

        changeOnObject(managedObject)

        try saveContext()
    }

}
