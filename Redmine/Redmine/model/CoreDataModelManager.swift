//
//  CoreDataModelManager.swift
//  Redmine
//
//  Created by David Martinez on 28/9/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import Foundation
import CoreData
import UIKit

/**
 This class configure, save, modify, and recover information from data
 model defined for this application
 
 - Seealso: For more information: https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CoreData/InitializingtheCoreDataStack.html#//apple_ref/doc/uid/TP40001075-CH4-SW1
 */
class CoreDataModelManager : NSObject {

    private static let instance = CoreDataModelManager()
    private var managedObjectContext : NSManagedObjectContext!
    
    private let MODEL_NAME = "Model"
    private let MODEL_EXTENSION_NAME = "momd"
    
    private override init () {
        super.init()
        initializeCoreData()
    }
    
    // MARK: Services
    static func getInstance () -> CoreDataModelManager {
        return CoreDataModelManager.instance
    }
    
    func getManagedObjectContext() -> NSManagedObjectContext {
        return managedObjectContext
    }
    
    func getAccountStorageManager () -> AccountStorage {
        let moc = getManagedObjectContext()
        let manager = AccountCoreData(managedObjectContext: moc)
        return manager
    }
    
    // MARK: Internal
    func initializeCoreData()  {
        
        guard let modelUrl = Bundle.main.url(forResource: MODEL_NAME, withExtension: MODEL_EXTENSION_NAME) else {
            fatalError("Core Data couldn't be initialized")
        }
        
        // The managed object model for the application. It is a fatal error 
        // for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOf: modelUrl) else {
            fatalError("Error initializing mom from: \(modelUrl)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        
        DispatchQueue.global().async {
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            var docURL = urls[urls.endIndex-1]
            /* 
             The directory the application uses to store the Core Data store file.
             This code uses a file named "DataModel.sqlite" in the application's documents directory.
             */
            docURL.appendPathComponent("DataModel.sqlite")
            do {
                try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: docURL, options: nil)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }

    }
}
