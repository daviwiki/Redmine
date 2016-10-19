//
//  LoginReadAccounts.swift
//  Redmine
//
//  Created by David Martinez on 19/10/16.
//  Copyright © 2016 Atenea. All rights reserved.
//

import UIKit

class LoginReadAccounts: NSObject, LoginReadAccountsInterface {
    
    func readAccounts (callback : ([Account]) -> ()) {
        let storage = LoginFactory.getInstance().getLoginAccountStorage()
        let accounts = storage.getAccounts()
        callback(accounts)
    }
    
}
