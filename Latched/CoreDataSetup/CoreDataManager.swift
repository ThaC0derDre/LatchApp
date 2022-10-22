//
//  CoreDataManager.swift
//  Latched!
//
//  Created by Andres Gutierrez on 10/19/22.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    // container loads models, to access data.
    let container = NSPersistentContainer(name: "CoreDataContainer")
    
    init(){
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData failed to load: \(error.localizedDescription)")
            }
        }
        self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
}
