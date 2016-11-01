//
//  AccountStorage.swift
//  Redmine
//
//  Created by David Martinez on 28/9/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol AccountStorageInterface {
    
    /**
     Return a list of all the accouts item storage at persisten location
     - Returns:
        Account list storage or nil if any account is storage
     */
    func getAccounts () -> [Account]
    
    /**
     Return the account for the name given
    */
    func getAccountForName (_ name : String) -> Account?
    
    /**
     Update account data
     - Parameters:
     account, account to be updated
    */
    func updateAccount (account : Account)
    
    /**
     Save the account given by parameters into persistent location
     - Parameters:
     account, account to be saved
     */
    func saveAccount (account : Account)
    
    /**
     Remove the account defined by parameter. If this account not exists, this
     method do nothing
     */
    func removeAccount (account : Account)
    
}
