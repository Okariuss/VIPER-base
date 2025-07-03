//
//  CoreDataManager.swift
//  iosBase
//
//  Created by Okan Orkun on 29.05.2025.
//

import CoreData

/// Manages Core Data stack and context operations.
final class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    /// The persistent container for the app.
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "iosBase")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData load error: \(error)")
            }
        }
        return container
    }()

    /// The main managed object context.
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    /// Saves changes in the context if any exist.
    func saveContext() {
        let context = persistentContainer.viewContext
        guard context.hasChanges else { return }

        do {
            try context.save()
        } catch {
            print("Failed to save Core Data context: \(error)")
        }
    }
}
