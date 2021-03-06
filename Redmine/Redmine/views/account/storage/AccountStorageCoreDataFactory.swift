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
class AccountStorageCoreDataFactory : NSObject {

    private static let instance = AccountStorageCoreDataFactory()
    private var managedObjectContext : NSManagedObjectContext?
    
    private let MODEL_NAME = "Model"
    private let MODEL_EXTENSION_NAME = "momd"
    
    private override init () {
        super.init()
    }
    
    // MARK: Services
    static func getInstance () -> AccountStorageCoreDataFactory {
        return AccountStorageCoreDataFactory.instance
    }
    
    func getManagedObjectContext(_ callback : @escaping (NSManagedObjectContext) -> Void) {
        if (managedObjectContext == nil) {
            initializeCoreData(callback)
        } else {
            callback(managedObjectContext!)
        }
    }
    
    func getAccountStorageManager (_ callback : @escaping (AccountStorageInterface) -> Void) {
        getManagedObjectContext { (moc : NSManagedObjectContext) in
            let manager = AccountStorageCoreData(managedObjectContext: moc)
            callback(manager)
        }
    }
    
    // MARK: Internal
    func initializeCoreData(_ callback : @escaping (NSManagedObjectContext) -> Void)  {
        
        guard let modelUrl = Bundle.main.url(forResource: MODEL_NAME, withExtension: MODEL_EXTENSION_NAME) else {
            fatalError("Core Data couldn't be initialized")
        }
        
        // The managed object model for the application. It is a fatal error 
        // for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOf: modelUrl) else {
            fatalError("Error initializing mom from: \(modelUrl)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        moc.persistentStoreCoordinator = psc
        managedObjectContext = moc
        
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
            
            DispatchQueue.main.sync {
                callback(moc)
            }
        }

    }
}
