//
//  CoreDataServise.swift
//  numiaChat
//
//  Created by Kamil Suleymanov on 09.09.2022.
//

import CoreData

final class CoreDataService {
    
    // MARK: - Properties
    
    static let shared = CoreDataService()
    
    var messages: [NSManagedObject] = []
    
    // MARK: - Core Data
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Chat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Fetch Core Data
    
    func fetchData() -> [NSManagedObject] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MessageEntity")
        
        do {
            messages = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return messages
    }
    
    // MARK: - Core Data Saving Methods
    
    func saveData(message: MessageViewModel) {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MessageEntity", in: context)!
        let messageEntity = NSManagedObject(entity: entity, insertInto: context)
        messageEntity.setValue(message.id, forKeyPath: "id")
        messageEntity.setValue(message.message, forKeyPath: "message")
        messageEntity.setValue(message.image, forKeyPath: "avatar")
        messageEntity.setValue(message.date, forKeyPath: "date")
        
        do {
            try context.save()
            print("Data successfully saved.")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
  
    // MARK: - Core Data Delete Methods
    
    func deleteEntity(object: NSManagedObject) {
        let context = persistentContainer.viewContext
        context.delete(object)
        do {
            try context.save()
        } catch {
            print("error deleting coreData object: \(error.localizedDescription)")
        }
    }
    
}


