//
//  ATESignUpViewController.swift
//  Redmine
//
//  Created by David Martinez on 26/9/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class ATESignUpViewController: UIViewController {

    private var accountStorage : AccountStorage?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
        accountStorage = CoreDataModelManager.getInstance().getAccountStorageManager()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: View
    private func configureView () {
        self.title = "Create Account"
    }
    
    // MARK: Presenters - Interactor
    private func storeAccount (name : String, host : String, token : String) {
        // TODO: ¿Comprobar en el futuro si guardar solo una vez que se haya 
        // comprobado un proceso de login valido ?
        
        let account = Account()
        account.name = name
        account.host = host
        account.token = token
        
        if (accountExists(account: account)) {
            // TODO: Avisar al usuario. No se puede guardar una cuenta ya existente
            print("[SignUpViewController] - Account already exists with name \(name)")
            return
        }
        
        persistAccount(account: account)
        print("[SignUpViewController] - Account saves successfully \(name)")
    }
    
    private func accountExists (account : Account) -> Bool {
        let accounts = accountStorage?.getAccounts()
        let index = accounts?.index(of: account)
        return index != nil
    }
    
    // MARK: Storage
    private func persistAccount (account : Account) {
        accountStorage?.saveAccount(account: account)
    }
}
