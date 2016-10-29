//
//  GetAccountsInteractor.swift
//  Redmine
//
//  Created by David Martinez on 29/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class AccountsInteractor: NSObject, AccountsInteractorInterface {

    func getAccounts(_ callback: @escaping ([Account]) -> Void) {
        AccountFactory.getInstance().getAccountStorage({ (storage : AccountStorageInterface) in
            let accounts = storage.getAccounts()
            callback(accounts)
        })
    }
    
    func removeAccount(_ account: Account, _ callback: @escaping (Account, Bool) -> Void) {
        AccountFactory.getInstance().getAccountStorage({ (storage : AccountStorageInterface) in
            storage.removeAccount(account: account)
            callback(account, true)
        })
    }
    
}
