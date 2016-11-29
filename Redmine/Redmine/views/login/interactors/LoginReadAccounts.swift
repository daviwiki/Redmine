//
//  LoginReadAccounts.swift
//  Redmine
//
//  Created by David Martinez on 19/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class LoginReadAccounts: NSObject, LoginReadAccountsInterface {
    
    typealias StorageProvider = ( @escaping (_ storage : AccountStorageInterface) -> Void) -> ()
    
    private var storageProvider : StorageProvider!
    
    func setAccountStorage (_ storage : @escaping StorageProvider) {
        storageProvider = storage
    }
    
    func readAccounts (callback : @escaping ([Account]) -> ()) {
        
        func getStorage (storage : AccountStorageInterface) -> Void {
            let accounts = storage.getAccounts()
            callback(accounts)
        }
        
        storageProvider(getStorage)
    }
    
    func readSelectedAccount(callback: @escaping (Account?) -> ()) {
        
        func getStorage (storage : AccountStorageInterface) -> Void {
            let accounts = storage      .getAccounts()
            for account in accounts {
                if account.isSelected {
                    callback (account)
                    return
                }
            }
            callback (nil)
        }
        
        storageProvider(getStorage)
    }
}
