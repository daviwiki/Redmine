//
//  LoginReadAccounts.swift
//  Redmine
//
//  Created by David Martinez on 19/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class LoginReadAccounts: NSObject, LoginReadAccountsInterface {
    
    func readAccounts (callback : @escaping ([Account]) -> ()) {
        LoginFactory.getInstance().getLoginAccountStorage { (storage : AccountStorageInterface) in
            let accounts = storage.getAccounts()
            callback(accounts)
        }
    }
    
    func readSelectedAccount(callback: @escaping (Account?) -> ()) {
        LoginFactory.getInstance().getLoginAccountStorage { (storage : AccountStorageInterface) in
            let accounts = storage.getAccounts()
            for account in accounts {
                if account.isSelected {
                    callback (account)
                    return
                }
            }
            callback (nil)
        }
    }
}
