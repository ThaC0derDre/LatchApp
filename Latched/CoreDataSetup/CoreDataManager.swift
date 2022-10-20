//
//  CoreDataManager.swift
//  Latched!
//
//  Created by Andres Gutierrez on 10/19/22.
//

import Foundation
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    
    let container : NSPersistentContainer
    let context : NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { desc, error in
            if let error{
                print("Error loading CoreData Container: \(error)")
            }
        }
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
            print("Saved Successfully")
        } catch let error {
            print("Error saving CoreData: \(error.localizedDescription)")
        }
    }
}
