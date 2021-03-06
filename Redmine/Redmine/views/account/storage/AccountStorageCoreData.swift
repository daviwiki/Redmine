//
//  AccountStorage.swift
//  Redmine
//
//  Created by David Martinez on 28/9/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit
import CoreData

extension AccountMO {
    
    func buildAccountFrom() -> Account {
        let account = Account()
        account.name = name!
        account.host = host!
        account.token = token!
        account.isSelected = selected
        account.order = Int(order)
        return account
    }
    
}

class AccountStorageCoreData : NSObject, AccountStorageInterface {

    var moc : NSManagedObjectContext!
    
    /**
     Set the NSManagedObjectContext object neccessary to manage
     all coredata operations that involves accounts
    */
    init (managedObjectContext moc : NSManagedObjectContext) {
        super.init()
        self.moc = moc
    }
    
    func getAccounts () -> [Account] {
        let accountFetch : NSFetchRequest<AccountMO> = AccountMO.fetchRequest()
        
        do {
            let fetchedAccounts = try moc.fetch(accountFetch)
            
            var results : [Account] = []
            for entity in fetchedAccounts {
                results.append(entity.buildAccountFrom())
            }
            return results
        } catch {
            print("[AccountCoreData] Accounts information couldn't be recovered")
        }
        
        return []
    }
    
    func getAccountForName (_ name : String) -> Account? {
        guard let accountMO = getAccountMO(forName: name) else { return nil }
        return accountMO.buildAccountFrom()
    }
    
    func saveAccount (account : Account) {
        let entity = NSEntityDescription.insertNewObject(
            forEntityName: "Account",
            into: moc) as! AccountMO
        
        entity.name = account.name
        entity.host = account.host
        entity.token = account.token
        entity.selected = account.isSelected
        entity.order = Int32 (account.order)
        
        do {
            try moc.save()
        } catch {
            print("[AccountCoreData] Account item couldn't be saved")
        }
    }
    
    func updateAccount(account: Account) {
        guard let accountMO = getAccountMO(forName: account.name) else {
            print("[AccountCoreData] No item to be updated")
            return
        }
        
        accountMO.name = account.name
        accountMO.host = account.host
        accountMO.token = account.token
        accountMO.order = Int32 (account.order)
        accountMO.selected = account.isSelected
        
        do {
            try moc.save()
        } catch {
            print("[AccountCoreData] Account item couldn't be updated")
        }
    }
    
    func removeAccount (account : Account) {
        guard let accountMO = getAccountMO(forName: account.name) else { return }
        moc.delete(accountMO)
        do {
            try moc.save()
        } catch {
            print("[AccountCoreData] Account item couldn't be deleted")
        }
    }
    
    func removeAll () {
        let accountFetch : NSFetchRequest<AccountMO> = AccountMO.fetchRequest()
        
        do {
            let fetchedAccounts = try moc.fetch(accountFetch)
            for item in fetchedAccounts {
                moc.delete(item)
            }
            try moc.save()
            
        } catch let error as NSError {
            print ("[AccountCoreData] remove all items failed \(error)")
        }
    }
    
    // MARK: Internal
    private func getAccountMO (forName name : String) -> AccountMO? {
        let accountFetch : NSFetchRequest<AccountMO> = AccountMO.fetchRequest()
        accountFetch.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let fetchedAccounts = try moc.fetch(accountFetch)
            return fetchedAccounts.first
            
        } catch {
            print("[AccountCoreData] Account information couldn't be recovered for name \(name)")
        }
        
        return nil
    }
}
