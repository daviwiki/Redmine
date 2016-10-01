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
        account.name = self.name!
        account.host = self.host!
        account.token = self.token!
        return account
    }
    
}

class AccountCoreData: NSObject, AccountStorage {

    var moc : NSManagedObjectContext!
    
    /**
     Save the account given by parameters into persistent location
     - Parameters:
        account, account to be saved
    */
    func saveAccount (account : Account) {
        // TODO: Fix save coredata
        let entity = NSEntityDescription.insertNewObject(
            forEntityName: "Account",
            into: moc) as! AccountMO
        
        entity.name = account.name
        entity.host = account.host
        entity.token = account.token
        
        do {
            try moc.save()
        } catch {
            print("[AccountCoreData] Account item couldn't be saved")
        }
    }
    
    /**
     Return a list of all the accouts item storage at persisten location
     - Returns:
        Account list storage or nil if any account is storage
    */
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
    
    /**
     Remove the account defined by parameter. If this account not exists, this
     method do nothing
     */
    func removeAccount (account : Account) {
        guard let accountMO = getAccountMO(forName: account.name) else { return }
        moc.delete(accountMO)
        do {
            try moc.save()
        } catch {
            print("[AccountCoreData] Account item couldn't be deleted")
        }
    }
    
    // MARK: Internal
    func getAccountMO (forName name : String) -> AccountMO? {
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
