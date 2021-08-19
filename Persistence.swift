//
//  Persistence.swift
//  FlashPad
//
//  Created by Emre Yasa on 8/18/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init (inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FlashPad")
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as? NSError {
                fatalError("Unresolved error: \(error)")
            }
        }
    }
}

