//
//  SingUpInteractor.swift
//  Redmine
//
//  Created by David Martinez on 1/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

protocol SignUpInteractorInterface : NSObjectProtocol {
    
    /**
     Try to store the account for the information given.
     - Parameters:
        name, account name
        host, account host (must be absolute url)
        token, account token
        callback,
     - Important:
     You must check if the account information is valid before call this
     method using isValidAccountInfo located in this class
    */
    func createAccount (
        name : String?, host : String?, token: String?,
        callback: (_ isValid: Bool, _ errorMessage: String?) -> Void)

}

class SignUpInteractor: NSObject, SignUpInteractorInterface {

    let localizableFileName = "SignUp"
    var accountStorage : AccountStorage?
    
    // MARK: Lifecycle
    override init() {
        super.init()
        
        // TODO: Solve this injection
        accountStorage = AccountCoreData()
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
        
        let account = Account()
        account.name = name!
        account.host = host!
        account.token = token!
        
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
