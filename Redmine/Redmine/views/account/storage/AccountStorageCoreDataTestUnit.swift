//
//  AccountStorageCoreDataTestUnit.swift
//  Redmine
//
//  Created by David Martinez on 1/11/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import XCTest
import CoreData
@testable import Redmine

class AccountStorageCoreDataTestUnit: XCTestCase {
    
    var moc : NSManagedObjectContext!
    var storage : AccountStorageCoreData!
    
    override func setUp() {
        super.setUp()
        moc = setUpInMemoryManagedObjectContext()
        storage = AccountStorageCoreData(managedObjectContext: moc)
    }
    
    override func tearDown() {
        super.tearDown()
        storage.removeAll()
    }
    
    func test_should_save_account () {
        let previous = getRandomAccount()
        storage.saveAccount(account: previous)
        
        let accounts = storage.getAccounts()
        XCTAssertTrue(accounts.count == 1)
        
        let storageAccount = accounts.first!
        XCTAssertEqual(storageAccount.name, previous.name)
        XCTAssertEqual(storageAccount.isSelected, previous.isSelected)
        XCTAssertEqual(storageAccount.order, previous.order)
    }
    
    func test_should_save_multiple_accounts () {
        let account1 = getRandomAccount()
        let account2 = getRandomAccount()
        let account3 = getRandomAccount()
        storage.saveAccount(account: account1)
        storage.saveAccount(account: account2)
        storage.saveAccount(account: account3)
        
        let accounts = storage.getAccounts()
        XCTAssertTrue(accounts.count == 3)
        
        let accountRecover1 = storage.getAccountForName(account1.name)!
        XCTAssertEqual(account1.name, accountRecover1.name)
        let accountRecover3 = storage.getAccountForName(account3.name)!
        XCTAssertEqual(account3.name, accountRecover3.name)
    }
    
    func test_should_recover_account_by_name () {
        let account1 = getRandomAccount()
        let account2 = getRandomAccount()
        let account3 = getRandomAccount()
        storage.saveAccount(account: account1)
        storage.saveAccount(account: account2)
        storage.saveAccount(account: account3)
        
        let account = storage.getAccountForName(account2.name)!
        XCTAssertEqual(account.name, account2.name)
        XCTAssertEqual(account.isSelected, account2.isSelected)
        XCTAssertEqual(account.order, account2.order)
    }
    
    func test_should_recover_all_accounts () {
        let account1 = getRandomAccount()
        let account2 = getRandomAccount()
        storage.saveAccount(account: account1)
        storage.saveAccount(account: account2)
        
        let accounts = storage.getAccounts()
        XCTAssertTrue(accounts.count == 2)
    }
    
    func test_should_update_account () {
        let account1 = getRandomAccount()
        storage.saveAccount(account: account1)
        
        var accountRecovered1 = storage.getAccountForName(account1.name)!
        XCTAssertEqual(accountRecovered1.isSelected, true)
        
        account1.isSelected = false
        storage.updateAccount(account: account1)
        
        accountRecovered1 = storage.getAccountForName(account1.name)!
        XCTAssertEqual(accountRecovered1.isSelected, false)
        
        // Update must not add new items
        XCTAssertEqual(storage.getAccounts().count, 1)
    }
    
    func test_should_remove_account () {
        let account1 = getRandomAccount()
        storage.saveAccount(account: account1)
        XCTAssertEqual(storage.getAccounts().count, 1)
        storage.removeAccount(account: account1)
        XCTAssertEqual(storage.getAccounts().count, 0)
    }
    
    func test_should_remove_all_accounts () {
        let account1 = getRandomAccount()
        let account2 = getRandomAccount()
        let account3 = getRandomAccount()
        storage.saveAccount(account: account1)
        storage.saveAccount(account: account2)
        storage.saveAccount(account: account3)
        
        XCTAssertEqual(storage.getAccounts().count, 3)
        storage.removeAll()
        XCTAssertEqual(storage.getAccounts().count, 0)
    }
    
    // MARK: Private
    func setUpInMemoryManagedObjectContext() -> NSManagedObjectContext {
        let mom = NSManagedObjectModel.mergedModel(from: [Bundle.main])
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom!)
        
        do {
            try psc.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            print("Adding in-memory persistent store failed")
        }
        
        let moc = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        moc.persistentStoreCoordinator = psc
        
        return moc
    }
    
    private func getRandomAccount () -> Account {
        let rand = arc4random()
        let account = Account()
        account.name = "name \(rand)"
        account.host = "host \(rand)"
        account.token = "token \(rand)"
        account.isSelected = true
        account.order = 0
        return account
    }
}
