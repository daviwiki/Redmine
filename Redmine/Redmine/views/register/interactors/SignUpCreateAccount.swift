//
//  SingUpInteractor.swift
//  Redmine
//
//  Created by David Martinez on 1/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class SignUpCreateAccount: NSObject, SignUpCreateAccountInterface {

    let localizableFileName = "SignUp"
    var accountStorage : AccountStorageInterface?
    
    // MARK: Lifecycle
    override init() {
        super.init()
        SignUpFactory.getSignUpAccountStorage({ [weak self] (storage : AccountStorageInterface) in
            self?.accountStorage = storage
        })
    }
    
    // MARK: SignUpInteractorInterface
    func createAccount(name: String?, host: String?, token: String?, callback: (Bool, String?) -> Void) {
        if (name == nil || name!.isEmpty) {
            let message = self.getLocalizable(fromId: "error_name_empty")!
            callback(false, message)
            return
        }
        
        if (host == nil || host!.isEmpty) {
            let message = self.getLocalizable(fromId: "error_host_empty")!
            callback(false, message)
            return
        }
        
        if (URL(string: host!) == nil) {
            let message = self.getLocalizable(fromId: "error_host_not_valid")!
            callback(false, message)
            return
        }
        
        if (token == nil || token!.isEmpty) {
            let message = self.getLocalizable(fromId: "error_token_emtpy")!
            callback(false, message)
            return
        }
        
        if (accountExists(name: name!, host: host!, token: token!)) {
            let message = self.getLocalizable(fromId: "error_account_exists")!
            callback(false, message)
            return
        }
        
        let storedAccounts = accountStorage?.getAccounts()
        let isSelected = storedAccounts!.count == 0
        
        let account = Account()
        account.name = name!
        account.host = host!
        account.token = token!
        account.isSelected = isSelected
        account.order = 0
        
        persistAccount(account: account)
        print("[SignUpViewController] - Account saves successfully \(name)")
        
        callback (true, nil)
    }
    
    // MARK: Internal
    private func accountExists (name: String, host: String, token: String) -> Bool {
        let account = Account()
        account.name = name
        account.host = host
        account.token = token
        
        let accounts = accountStorage?.getAccounts()
        let index = accounts?.index(of: account)
        return index != nil
    }
    
    private func persistAccount (account : Account) {
        accountStorage?.saveAccount(account: account)
    }
    
    private func getLocalizable (fromId id : String) -> String? {
        return NSLocalizedString(id, tableName: localizableFileName, bundle: Bundle.main, value: "", comment: "")
    }
}
