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
    
    func getSelectedAccount(_ callback: @escaping (Account?) -> Void) {
        // TODO: Por eficencia, generar una query que solo busque la cuenta
        // seleccionada en base de datos en lugar de traer todos las cuentas
        // y luego buscar
        AccountFactory.getInstance().getAccountStorage({ (storage : AccountStorageInterface) in
            let accounts = storage.getAccounts()
            for account in accounts {
                if (account.isSelected) {
                    callback(account)
                    return
                }
            }
            
            callback(nil)
        })
    }
    
    func selectAccount(_ account: Account, _ callback: @escaping (Account) -> Void) {
        AccountFactory.getInstance().getAccountStorage({ [weak self] (storage : AccountStorageInterface) in
            let accounts = storage.getAccounts()
            var accountsToBeUpdated : [Account] = []
            
            for item in accounts {
                if (item.isSelected && item.name != account.name) {
                    item.isSelected = false
                    accountsToBeUpdated.append(item)
                }
            }
            
            accountsToBeUpdated.append(account)
            
            for item in accountsToBeUpdated {
                self?.updateAccount(item, { (account : Account) in
                    // do nothing
                })
            }
            
            callback(account)
        })
    }
    
    func updateAccount(_ account: Account, _ callback: @escaping (Account) -> Void) {
        AccountFactory.getInstance().getAccountStorage { (storage : AccountStorageInterface) in
            storage.updateAccount(account: account)
            callback (account)
        }
    }
    
    func removeAccount(_ account: Account, _ callback: @escaping (Account, Bool) -> Void) {
        AccountFactory.getInstance().getAccountStorage({ (storage : AccountStorageInterface) in
            storage.removeAccount(account: account)
            callback(account, true)
        })
    }
    
}
